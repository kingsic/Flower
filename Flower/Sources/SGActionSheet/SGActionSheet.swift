//
//  SGActionSheet.swift
//  Flower
//
//  Created by kingsic on 2022/2/6.
//

import UIKit

public struct MessageContentInset {
    public var top: CGFloat = 20.0
    public var left: CGFloat = 25.0
    public var bottom: CGFloat = 20.0
    public var right: CGFloat = 25.0
}

public class SGActionSheetConfigure: NSObject {
    /// 背景颜色，默认为：.clear
    public var backgroundColor: UIColor = .clear
    
    /// 圆角大小，默认为：10
    public var cornerRadius: CGFloat = 10
    
    /// 行高，默认为：50
    public var height: CGFloat = 50
    
    /// 点击时的背景色，默认为：.black.withAlphaComponent(0.05)
    public var color: UIColor = .black.withAlphaComponent(0.05)
    
    /// 分割线颜色，默认为：.black.withAlphaComponent(0.05)
    public var separatorColor: UIColor = .black.withAlphaComponent(0.05)
    
    /// 弹出动画所需时间，默认为：0.25
    public var animateDuration: Double = 0.25
    
    /// 提示信息文字
    public var message: String = ""
    
    /// 提示信息文字颜色，默认为：.black.withAlphaComponent(0.8)
    public var messageColor: UIColor = .black.withAlphaComponent(0.8)
    
    /// 提示信息文字大小，默认为：.systemFont(ofSize: 15)
    public var messageFont: UIFont = .systemFont(ofSize: 15)
    
    /// 提示信息的内边距
    public var messageContentInset: MessageContentInset = .init()
    
    /// 标题文字颜色，默认为：.black
    public var titlesColor: UIColor = .black
    
    /// 标题文字大小，默认为：.systemFont(ofSize: 17)
    public var titlesFont: UIFont = .systemFont(ofSize: 17)
    
    /// 取消文字，默认为：取消
    public var cancel: String = "取消"
    
    /// 取消文字颜色，默认为：.black
    public var cancelColor: UIColor = .black
    
    /// 取消文字大小，默认为：.systemFont(ofSize: 17)
    public var cancelFont: UIFont = .systemFont(ofSize: 17)
}


public class SGActionSheet: UIViewController {
    /// 配置类
    public var configure: SGActionSheetConfigure!
    
    public typealias SGActionSheetBlock = (_ actionSheet: SGActionSheet, _ index: Int) -> ()
    private var block: SGActionSheetBlock?
    /// 标题的点击回调方法
    public func titlesClickBlock(block: @escaping SGActionSheetBlock) {
        self.block = block
    }
    
    /// 根据标题下标值设置标题文字颜色、大小
    public func setTitle(color: UIColor, font: UIFont = .systemFont(ofSize: 17), index: Int) {
        if index >= 0 && index <= titles.count {
            DispatchQueue.main.async { [self] in
                titleBtns[index].setTitleColor(color, for: .normal)
                titleBtns[index].titleLabel?.font = font
            }
        }
    }
    
    public init(titles: [String], configure: SGActionSheetConfigure) {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .custom
        self.titles = titles
        self.configure = configure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// titles
    private var titles: Array<String> = Array()
    /// titleBtns
    private var titleBtns: Array<UIButton> = Array()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
                
        if configure.message.count > 0 {
            contentView.addSubview(messageView)
            messageView.addSubview(messageLab)
            messageView.addSubview(sepView)
        }
        
        if titles.count > 0 {
            addTitles()
        }
        
        contentView.addSubview(cancelBtn)
        cancelBtn.addSubview(cancelLab)
        
        layoutSubViews()
        
        guard configure.cornerRadius > 0 else {
            return
        }
        setCornerRadius()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = configure.backgroundColor
    }
    
    lazy var contentView: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white.withAlphaComponent(0.77)
        return view
    }()
    
    lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var messageLab: UILabel = {
        let screen_w = UIScreen.main.bounds.width

        let lab = UILabel()
        let height: CGFloat = configure.height
        let x = configure.messageContentInset.left
        let y = configure.messageContentInset.top
        let w = screen_w - x - configure.messageContentInset.right
        let h = configure.message.calculateStringHeight(width: w, font: configure.messageFont)
        lab.frame = CGRect(x: x, y: y, width: w, height: h)
        let bgHeight = y + h + configure.messageContentInset.bottom
        messageView.frame = CGRect(x: 0, y: 0, width: screen_w, height: bgHeight)
        sepView.frame = CGRect(x: 0, y: bgHeight - 1, width: screen_w, height: 1)
        lab.text = configure.message
        lab.textColor = configure.messageColor
        lab.font = configure.messageFont
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    lazy var sepView: UIView = {
        let sepView = UIView()
        sepView.backgroundColor = configure.separatorColor
        return sepView
    }()

    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.setBackgroundImage(configure.color.toImage(), for: .highlighted)
        btn.addTarget(self, action: #selector(cancelBtn_action), for: .touchUpInside)
        return btn
    }()
    lazy var cancelLab: UILabel = {
        let lab = UILabel()
        let height: CGFloat = configure.height
        lab.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        lab.text = configure.cancel
        lab.textColor = configure.cancelColor
        lab.font = configure.cancelFont
        lab.textAlignment = .center
        return lab
    }()
}

public extension UIViewController {
    func actionSheet(_ actionSheet: SGActionSheet) {
        present(actionSheet, animated: false) {
            UIView.animate(withDuration: actionSheet.configure.animateDuration) {
                actionSheet.contentView.transform = CGAffineTransform.init(translationX: 0, y: -actionSheet.contentView.frame.height)
            }
        }
    }
}

extension SGActionSheet {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    func dismiss() {
        UIView.animate(withDuration: configure.animateDuration) { [self] in
            contentView.transform = .identity
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + configure.animateDuration) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}


fileprivate extension SGActionSheet {
    func addTitles() {
        let x: CGFloat = 0
        var y: CGFloat = configure.message.count > 0 ? messageView.frame.maxY : 0
        let w: CGFloat = UIScreen.main.bounds.width
        let h: CGFloat = configure.height
        for (index, title) in titles.enumerated() {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            y += h;
            btn.tag = index
            btn.backgroundColor = .white
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(configure.titlesColor, for: .normal)
            btn.titleLabel?.font = configure.titlesFont
            btn.setBackgroundImage(configure.color.toImage(), for: .highlighted)
            btn.addTarget(self, action: #selector(titleBtn_action(btn:)), for: .touchUpInside)
            contentView.addSubview(btn)
            titleBtns.append(btn)
            
            if index != (titles.count - 1) {
                let sepView = UIView()
                let sepHeight: CGFloat = 1
                sepView.frame = CGRect(x: 0, y: h - sepHeight, width: w, height: sepHeight)
                sepView.backgroundColor = configure.separatorColor
                btn.addSubview(sepView)
            }
        }
    }
}

fileprivate extension SGActionSheet {
    @objc func titleBtn_action(btn: UIButton) {
        dismiss()

        if let tempBlock = block {
            tempBlock(self, btn.tag)
        }
    }
    
    @objc func cancelBtn_action() {
        dismiss()
    }
}

fileprivate extension SGActionSheet {
    func layoutSubViews() {
        let messageHeight = configure.message.count > 0 ? messageView.frame.height : 0
        let titlesHeight = titles.count > 0 ? (CGFloat(titles.count) * configure.height) : 0
        let cancelHeight: CGFloat = UIScreen.statusBarHeight == 20 ? configure.height : (34 + configure.height)

        let height: CGFloat = messageHeight + cancelHeight + titlesHeight + 7
        
        contentView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: height)
        
        let cancelY = contentView.frame.height - cancelHeight
        cancelBtn.frame = CGRect(x: 0, y: cancelY, width: UIScreen.main.bounds.width, height: cancelHeight)
    }
    
    func setCornerRadius() {
        if configure.cornerRadius > 30 {
            configure.cornerRadius = 30
        }
        let bPath = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: configure.cornerRadius, height: configure.cornerRadius))
        let sLayer = CAShapeLayer()
        sLayer.frame = contentView.bounds
        sLayer.path = bPath.cgPath
        contentView.layer.mask = sLayer
    }
}

fileprivate extension UIColor {
    /// Convert colors to UIImage
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let contextRef = UIGraphicsGetCurrentContext()
        contextRef?.setFillColor(self.cgColor)
        contextRef?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

fileprivate extension String {
    /// Calculate the height of a string based on width and font size
    ///
    /// - parameter width: CGFloat
    /// - parameter font: UIFont
    ///
    /// - returns: The height of the calculated string
    func calculateStringHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        let tempRect = (self as NSString).boundingRect(with: CGSize(width: width, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil)
        return tempRect.size.height
    }
}

fileprivate extension UIScreen {
    /// Gets status bar height
    static var statusBarHeight: CGFloat {
        if #available(iOS 13, *) {
            return (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height)!
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
}
