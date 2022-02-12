//
//  SGPopupMenu.swift
//  Flower
//
//  Created by kingsic on 2022/2/2.
//

import UIKit

public enum TriangleLocation {
    case Default, Center, Left
}

public struct SeparatorInset {
    public var left: CGFloat = 0.0
    public var right: CGFloat = 0.0
}

public class SGPopupMenuConfigure: NSObject {
    /// 背景颜色，默认为：.clear
    public var backgroundColor: UIColor = .clear
    
    /// 位置
    public var point: CGPoint = .zero
    
    /// 颜色，默认为：.white
    public var color: UIColor = .white
    
    /// 圆角大小，默认为：10
    public var cornerRadius: CGFloat = 10

    /// 宽度，默认为：130
    public var width: CGFloat = 130
    
    /// 行高度，默认为：44
    public var height: CGFloat = 44
    
    /// 是否显示垂直方向的指示器，默认为：false（当数据源个数大于 7 时，设置为 true 时才起作用）
    public var showsVerticalScrollIndicator = false
    
    /// 分割线颜色，默认为：.black.withAlphaComponent(0.2)
    public var separatorColor: UIColor = .black.withAlphaComponent(0.2)
    
    /// 分割线左右边距
    public var separatorInset: SeparatorInset = .init()
    
    /// 点击 item 时的背景颜色，默认为：.black.withAlphaComponent(0.2)
    public var selectedBackgroundColor: UIColor = .black.withAlphaComponent(0.2)
    
    /// 文字颜色，默认为：.black
    public var textColor: UIColor = .black
    
    /// 文字大小，默认为：.systemFont(ofSize: 15)
    public var textFont: UIFont = .systemFont(ofSize: 15)
    
    public typealias ImageViewBlock = (_ imageView: UIImageView, _ index: Int) -> Void
    fileprivate var tempImageViewBlock: ImageViewBlock?
    /// 图片回调方法
    public func imageViewBlock(block: @escaping ImageViewBlock) {
        tempImageViewBlock = block
    }
    
    /// 是否需要三角形，默认为：true
    public var isTriangle: Bool = true
    
    /// 三角形位置，默认为：.Default
    public var triangleLocation: TriangleLocation = .Default
    
    /// 三角形位置的偏移量，默认为：15（当 triangleLocation = .Center 时，不起作用）
    public var triangleLocationOffset: CGFloat = 15
    
    /// 三角形的宽，默认为：12
    public var triangleWidth: CGFloat = 12

    /// 三角形的高，默认为：6
    public var triangleHeight: CGFloat = 6
}


public class SGPopupMenu: UIViewController {
    /// 配置类
    public var configure: SGPopupMenuConfigure!
    
    /// 数据源
    public var dataSource: Array<String>? {
        didSet {
            dataSourceDidSet()
        }
    }
    
    public typealias SGPopupMenuBlock = (_ popupMenu: SGPopupMenu, _ index: Int) -> ()
    private var block: SGPopupMenuBlock?
    /// 菜单 item 的点击回调方法
    public func clickBlock(block: @escaping SGPopupMenuBlock) {
        self.block = block
    }
    
    public init(configure: SGPopupMenuConfigure) {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .custom
        self.configure = configure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(popupMenu)
        popupMenu.addSubview(tableView)
        if configure.isTriangle {
            view.addSubview(triangleView)
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = configure.backgroundColor
    }
    
    fileprivate lazy var triangleView : TriangleView = {
        let view = TriangleView(frame: .zero, configure: configure)
        let width: CGFloat = configure.triangleWidth
        let height: CGFloat = configure.triangleHeight
        let y = popupMenu.frame.minY - height
        var x: CGFloat = 0
        if configure.triangleLocation == .Default {
            let offset = configure.triangleLocationOffset < 0 ? 0 : configure.triangleLocationOffset
            x = popupMenu.frame.maxX - width - offset
        } else if configure.triangleLocation == .Center {
            x = popupMenu.frame.midX - 0.5 * width
        } else if configure.triangleLocation == .Left {
            let offset = configure.triangleLocationOffset < 0 ? 0 : configure.triangleLocationOffset
            x = popupMenu.frame.minX + offset
        }
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var popupMenu: UIView = {
        let menu = UIView()
        menu.backgroundColor = configure.color
        let width = configure.width
        menu.frame = CGRect(x: configure.point.x, y: configure.point.y, width: width, height: 0)
        menu.layer.cornerRadius = configure.cornerRadius
        return menu
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: popupMenu.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = configure.height
        tableView.separatorColor = configure.separatorColor
        tableView.showsVerticalScrollIndicator = configure.showsVerticalScrollIndicator
        tableView.layer.cornerRadius = configure.cornerRadius
        return tableView
    }()
}

public extension UIViewController {
    func popupMenu(_ menu: SGPopupMenu) {
        present(menu, animated: false, completion: nil)
    }
}

extension SGPopupMenu {
    func dataSourceDidSet() {
        guard dataSource?.count != 0 else {
            return
        }
        
        if dataSource!.count >= 7 {
            popupMenu.frame.size.height = 7 * configure.height
            tableView.frame.size.height = popupMenu.frame.size.height
        } else {
            tableView.bounces = false
            popupMenu.frame.size.height = CGFloat(dataSource!.count) * configure.height
            tableView.frame.size.height = popupMenu.frame.size.height
        }
        tableView.reloadData()
    }
}

extension SGPopupMenu: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = configure.selectedBackgroundColor
        cell.selectedBackgroundView = selectedBackgroundView
        cell.backgroundColor = .clear
        cell.textLabel?.text = dataSource![indexPath.row]
        cell.textLabel?.textColor = configure.textColor
        cell.textLabel?.font = configure.textFont
        if let block = configure.tempImageViewBlock {
            block(cell.imageView!, indexPath.row)
        }

        if indexPath.row == dataSource!.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.width)
        } else {
            if configure.separatorInset.left != 0 && configure.separatorInset.right != 0 {
                let left = configure.separatorInset.left < 0 ? 0 : configure.separatorInset.left
                let right = configure.separatorInset.right < 0 ? 0 : configure.separatorInset.right
                cell.separatorInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
            }
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: false) { [self] in
            if let tempBlock = block {
                tempBlock(self, indexPath.row)
            }
        }
    }
}

extension SGPopupMenu {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }
}


fileprivate class TriangleView: UIView {
    var configure: SGPopupMenuConfigure!

    init(frame: CGRect, configure: SGPopupMenuConfigure) {
        super.init(frame: frame)
        
        self.configure = configure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: rect.size.width * 0.5, y: 0))
        context?.addLine(to: CGPoint(x: 0, y: rect.size.height))
        context?.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        context?.closePath()
        configure.color.setStroke()
        configure.color.setFill()
        context?.drawPath(using: .fillStroke)
    }
}
