//
//  SGTagsView.swift
//  Flower
//
//  Created by kingsic on 2020/11/5.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

/// Tag layout style: uniform vertical style, adaptive vertical style and horizontal style
public enum SGTagsStyle {
    case equableVertical, vertical, horizontal
}

/// Position of tag content level
public enum SGTagContentHorizontalAlignment {
    case center, left, right
}

/// The position of the image in the tag relative to the text
public enum SGImagePositionStyle {
    case left, right, top, bottom
}

public class SGTagsViewConfigure: NSObject {
    /// default false. if true, bounces past edge of content and back again
    public var isBounces = false
    
    /// default true. show indicator while we are tracking. fades out after tracking
    public var isShowsVerticalScrollIndicator: Bool = true
    
    /// default true. show indicator while we are tracking. fades out after tracking
    public var isShowsHorizontalScrollIndicator: Bool = true
    
    /// The tag layout style is equal vertical by default
    public var style: SGTagsStyle = .equableVertical
    
    /// Whether the tag can be selected, the default is true
    public var isSelected = true
    
    /// Whether the tag supports multiple selection. The default value is false
    public var isMultipleSelect  = false
    
    /// The font size of tag text is 15 point font by default
    public var font: UIFont = .systemFont(ofSize: 15)
    
    /// In normal state, the color of tag text is black by default
    public var color: UIColor = .black
    
    /// In the selected state, the color of tag text is red by default
    public var selectedColor: UIColor = .black
    
    /// By default, the color is light gray
    public var backgroundColor: UIColor = UIColor(white: 0.92, alpha: 1.0)
    
    /// In the selected state, the tag background color is white by default
    public var selectedBackgroundColor: UIColor = .white
    
    /// Tag border width, the default is 0.0f
    public var borderWidth: CGFloat = 0.0
    
    /// In normal state, the color of tag border is white by default
    public var borderColor: UIColor = .white
    
    /// When selected, the color of tag border is red by default
    public var selectedBorderColor: UIColor = .red
    
    /// Tag fillet size, the default is 0.0f
    public var cornerRadius: CGFloat = 0.0
    
    /// The horizontal spacing between tags is 20.0f by default
    public var horizontalSpacing: CGFloat = 20.0
    
    /// The space between vertical tags is 20.0f by default
    public var verticalSpacing: CGFloat = 20.0
    
    /// The additional width of the tag. This width refers to the width beyond the tag text. The default value is 40.0f
    public var additionalWidth: CGFloat = 40.0
    
    /// In vertical style, the height of the tag is 30.0f by default
    public var height: CGFloat = 30.0
    
    /// In the equal style, the number of columns in each row of the tag is 3 by default
    public var column: Int = 3
    
    /// The distance between the tag and the inner edge of the parent view is 10 by default
    public var contentInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    /// The horizontal position of the tag content. The default is center
    public var contentHorizontalAlignment: SGTagContentHorizontalAlignment = .center
    
    /// When contenthorizontalalignment = left or right, the inner margin of the content is 5.0f by default
    public var padding: CGFloat = 5.0
}


private class SGTagButton: UIButton {
    override var isHighlighted: Bool {
        set {}
        get {return false}
    }
}


public class SGTagsView: UIView {
    public init(frame: CGRect, configure: SGTagsViewConfigure) {
        super.init(frame: frame)
        self.configure = configure
        addSubview(contentView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Tag titles
    public var tags: Array<String>? {
        didSet {
            setupTags()
        }
    }
    
    /// When initializing a tag, the tag subscript is selected by default (when multipleselect = no, only the tag corresponding to the last value is supported)
    public var tagIndexs: Array<Int>? {
        didSet {
            guard let tempTagIndexs = tagIndexs else {
                return
            }
            if tempTagIndexs.count == 0 {
                return
            }
            for i in tempTagIndexs {
                guard let btns = tempBtns else {
                    return
                }
                if btns.count == 0 {
                    return
                }
                tag_action(btn: btns[i])
            }
        }
    }
    
    /// In the equable vertical and vertical styles, whether to fix the height of the initial frame is set to false by default; if it is true, the content will scroll if it exceeds the height of the initial frame
    public var isFixedHeight: Bool = false
    
    public typealias SGTagsViewHeightBlock = (_ tagsView: SGTagsView, _ height: CGFloat) -> ()
    private var heightBlock: SGTagsViewHeightBlock?
    /// When isFixedheight = false, the callback function of SGTagsView height is returned after the tag layout is completed in equable Vertical and vertical styles
    public func heightBlock(heightBlock: @escaping SGTagsViewHeightBlock) {
        self.heightBlock = heightBlock;
    }
    
    public typealias SGTagsViewSingleSelectBlock = (_ tagsView: SGTagsView, _ tag: String, _ index: Int) -> ()
    private var singleSelectBlock: SGTagsViewSingleSelectBlock?
    /// Tag single selection callback function
    public func singleSelectBlock(singleSelectBlock: @escaping SGTagsViewSingleSelectBlock) {
        self.singleSelectBlock = singleSelectBlock
    }
    
    public typealias SGTagsViewMultipleSelectBlock = (_ tagsView: SGTagsView, _ tags: Array<Any>, _ index: Array<Int>) -> ()
    private var multipleSelectBlock: SGTagsViewMultipleSelectBlock?
    /// Tag multiple selection callback function
    public func multipleSelectBlock(multipleSelectBlock: @escaping SGTagsViewMultipleSelectBlock) {
        self.multipleSelectBlock = multipleSelectBlock
    }
    
    // MARK: 内部辅助属性
    private var configure: SGTagsViewConfigure!
    private lazy var contentView: UIScrollView = {
        let tempContentView = UIScrollView()
        tempContentView.bounces = configure.isBounces;
        return tempContentView
    }()
    private var tempBtns: Array<SGTagButton>? = []
    private var tempRow = 1
    private var bodyBtns: Array<SGTagButton>? = []
    private var tempBtn: UIButton?
    private var previousBtn: UIButton?
    private var titles: Array<String> = []
    private var indexs: Array<Int> = []
    
    public override func layoutSubviews() {
        let x: CGFloat = 0
        let y: CGFloat = 0
        let width = frame.size.width
        let height = frame.size.height
        contentView.frame = CGRect.init(x: x, y: y, width: width, height: height)
        
        if configure.style == .vertical {
            layoutTagsVerticalStyle()
        } else if configure.style == .horizontal {
            layoutTagsHorizontalStyle()
        } else {
            layoutTagsEquableVerticalStyle()
        }
    }
    
}

// MARK: 给外界提供的方法
public extension SGTagsView {
    /// Set tags image
    ///
    /// Support local and network images
    ///
    /// - parameter names: Tag images name
    /// - parameter imagePositionStyle: Position of image relative to text
    /// - parameter spacing: Space between image and text
    func setImage(names: Array<String>, imagePositionStyle: SGImagePositionStyle, spacing: CGFloat) {
        guard let btns = tempBtns else {
            return
        }
        if btns.count == 0 {
            return
        }
        if names.count < btns.count {
            for (index, btn) in btns.enumerated() {
                if index >= names.count {
                    return
                }
                setTagImage(btn: btn, imageName: names[index], imagePositionStyle: imagePositionStyle, spacing: spacing)
            }
        } else {
            for (index, btn) in btns.enumerated() {
                setTagImage(btn: btn, imageName: names[index], imagePositionStyle: imagePositionStyle, spacing: spacing)
            }
        }
    }
    
    /// Set the tag image according to the subscript
    ///
    /// Support local and network images
    ///
    /// - parameter names: Tag image name
    /// - parameter imagePositionStyle: Position of image relative to text
    /// - parameter spacing: Space between image and text
    /// - parameter index: Tag subscript
    func setImage(name: String, imagePositionStyle: SGImagePositionStyle, spacing: CGFloat, index: Int) {
        guard let btns = tempBtns else {
            return
        }
        if btns.count == 0 {
            return
        }
        let btn = btns[index]
        setTagImage(btn: btn, imageName: name, imagePositionStyle: imagePositionStyle, spacing: spacing)
    }
    
    /// Set inactive tags according to the subscript
    ///
    /// - parameter alpha: Tag alpha
    /// - parameter color: Tag title color
    /// - parameter index: Tag subscript
    func setUnEnabled(alpha: CGFloat = 0.8, color: UIColor = .gray, index: Int) {
        guard let btns = tempBtns else {
            return
        }
        if btns.count == 0 {
            return
        }
        let btn = btns[index]
        btn.isEnabled = false
        btn.alpha = alpha
        btn.layer.borderWidth = 0.01
        btn.layer.borderColor = UIColor.clear.cgColor
        btn.setTitleColor(color, for: .normal)
    }
}

// MARK: - 辅助标签设置 image 的方法
private extension SGTagsView {
    func setupTags() {
        guard let tempTags = tags else { return }
        if tempTags.count == 0 {  return }
        
        for (index, obj) in tempTags.enumerated() {
            let btn = SGTagButton()
            btn.tag = index
            btn.titleLabel?.font = configure.font
            btn.setTitle(obj, for: .normal)
            btn.setTitleColor(configure.color, for: .normal)
            btn.setTitleColor(configure.selectedColor, for: .selected)
            btn.backgroundColor = configure.backgroundColor
            if configure.isSelected {
                btn.addTarget(self, action: #selector(tag_action(btn:)), for: .touchUpInside)
            }
            if configure.borderWidth > 2.0 {
                btn.layer.borderWidth = 2
            } else {
                btn.layer.borderWidth = configure.borderWidth
            }
            if configure.cornerRadius > 0.5 * configure.height {
                btn.layer.cornerRadius = 0.5 * configure.height
            } else {
                btn.layer.cornerRadius = configure.cornerRadius
            }
            btn.layer.borderColor = configure.borderColor.cgColor
            if configure.contentHorizontalAlignment == .left {
                btn.contentHorizontalAlignment = .left
                btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: configure.contentInset.left, bottom: 0, right: 0)
            } else if configure.contentHorizontalAlignment == .right {
                btn.contentHorizontalAlignment = .right
                btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: configure.contentInset.right)
            }
            contentView.addSubview(btn)
            tempBtns!.append(btn)
            bodyBtns!.append(btn)
        }
    }
    
    func setTagImage(btn: UIButton, imageName: String, imagePositionStyle: SGImagePositionStyle, spacing: CGFloat) {
        if imageName.hasPrefix("http") {
            loadImage(urlString: imageName) { (image) in
                btn.setImage(image, for: .normal)
                self.setImage(btn: btn, imagePositionStyle: imagePositionStyle, spacing: spacing)
            }
        } else {
            btn.setImage(UIImage.init(named: imageName), for: .normal)
            setImage(btn: btn, imagePositionStyle: imagePositionStyle, spacing: spacing)
        }
    }
}

// MARK: - 标签点击事件相关逻辑方法处理
private extension SGTagsView {
    @objc func tag_action(btn: SGTagButton) {
        if configure.isMultipleSelect {
            btn.isSelected = !btn.isSelected
            if btn.isSelected {
                btn.backgroundColor = configure.selectedBackgroundColor
                btn.layer.borderColor = configure.selectedBorderColor.cgColor
                btn.setTitleColor(configure.selectedColor, for: .normal)
                titles.append(btn.titleLabel!.text!)
                indexs.append(btn.tag)
            } else {
                btn.backgroundColor = configure.backgroundColor
                btn.layer.borderColor = configure.borderColor.cgColor
                btn.setTitleColor(configure.color, for: .normal)
                titles.removeAll{$0 == btn.titleLabel!.text!}
                indexs.removeAll{$0 == btn.tag}
            }
            if let tempMultipleSelectBlock = multipleSelectBlock {
                tempMultipleSelectBlock(self, titles, indexs)
            }
            
            if contentView.contentSize.width > contentView.frame.size.width {
                selectedBtnCenter(btn: btn)
            }
            
        } else {
            changeSelectedBtn(btn: btn)
            if let tempSingleSelectBlock = singleSelectBlock {
                tempSingleSelectBlock(self, btn.titleLabel!.text!, btn.tag)
            }
            if contentView.contentSize.width > contentView.frame.size.width {
                selectedBtnCenter(btn: btn)
            }
        }
    }
    
    func changeSelectedBtn(btn: UIButton) {
        if tempBtn == nil {
            btn.isSelected =  true
            tempBtn = btn
        } else if tempBtn != nil && tempBtn == btn {
            btn.isSelected = true
        } else if tempBtn != nil && tempBtn != btn {
            tempBtn!.isSelected = false
            btn.isSelected = true
            tempBtn = btn
        }
        
        if previousBtn != nil {
            previousBtn?.backgroundColor = configure.backgroundColor
            previousBtn?.layer.borderColor = configure.borderColor.cgColor
            previousBtn?.setTitleColor(configure.color, for: .normal)
        }
        btn.backgroundColor = configure.selectedBackgroundColor
        btn.layer.borderColor = configure.selectedBorderColor.cgColor
        btn.setTitleColor(configure.selectedColor, for: .normal)
        previousBtn = btn
    }
    
    func selectedBtnCenter(btn: UIButton) {
        var offsetX = btn.center.x - contentView.frame.size.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffsetX = contentView.contentSize.width - contentView.frame.size.width
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        contentView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

// MARK: - 标签布局相关方法处理
private extension SGTagsView {
    func layoutTagsVerticalStyle() {
        auxLayoutTagsVerticalStyle()
        
        guard let btns = tempBtns else { return }
        if btns.count == 0 { return }
        
        let lastBtn: SGTagButton = btns.last!
        let contentViewHeight = lastBtn.frame.maxY + configure.contentInset.bottom

        if isFixedHeight {
            if contentViewHeight < contentView.frame.size.height {
                contentView.contentSize = CGSize(width: contentView.frame.size.width, height: contentView.frame.size.height)
            } else {
                contentView.contentSize = CGSize(width: contentView.frame.size.width, height: contentViewHeight)
                contentView.showsVerticalScrollIndicator = configure.isShowsVerticalScrollIndicator
            }
        } else {
            contentView.frame.size.height = contentViewHeight
            frame.size.height = contentViewHeight
            if let tempHeightBlcok = heightBlock {
                tempHeightBlcok(self, contentViewHeight)
            }
        }

    }
    func auxLayoutTagsVerticalStyle() {
        guard let btns = bodyBtns else {
            return
        }
        if btns.count == 0 {
            return
        }
        var btnX = configure.contentInset.left
        let btnY = CGFloat((tempRow - 1)) * (configure.verticalSpacing + configure.height)
            + configure.contentInset.top
        let btnH = configure.height
        let contentViewWidth = contentView.frame.size.width
        
        for (index, btn) in btns.enumerated() {
            let str_width = calculateWidth(str: btn.currentTitle!, font: configure.font)
            let btnW = str_width + configure.additionalWidth
            btn.frame = CGRect.init(x: btnX, y: btnY, width: btnW, height: btnH)
            btnX = btn.frame.maxX + configure.horizontalSpacing
            if btnX > contentViewWidth {
                tempRow += 1
                for _ in 0..<index {
                    bodyBtns?.removeFirst()
                }
                auxLayoutTagsVerticalStyle()
                return
            }
        }
    }
    
    func layoutTagsHorizontalStyle() {
        guard let btns = tempBtns else { return }
        if btns.count == 0 { return }
        
        var btnX = configure.contentInset.left
        let btnY = configure.contentInset.top
        let btnH = contentView.frame.size.height - btnY - configure.contentInset.bottom
        
        for (_, btn) in btns.enumerated() {
            let str_width = calculateWidth(str: btn.currentTitle!, font: configure.font)
            let btnW = str_width + configure.additionalWidth
            btn.frame = CGRect.init(x: btnX, y: btnY, width: btnW, height: btnH)
            btnX = btn.frame.maxX + configure.horizontalSpacing
        }
        
        let lastBtn: SGTagButton = btns.last!
        let lastBtnMaxX = lastBtn.frame.maxX
        let allContentWidth = lastBtnMaxX + configure.contentInset.right
        if allContentWidth < contentView.frame.size.width {
            contentView.contentSize = CGSize(width: contentView.frame.size.width, height: btnH)
        } else {
            contentView.contentSize = CGSize(width: allContentWidth, height: btnH)
            contentView.showsHorizontalScrollIndicator = configure.isShowsHorizontalScrollIndicator
        }
    }
    func layoutTagsEquableVerticalStyle() {
        guard let btns = tempBtns else { return }
        if btns.count == 0 { return }
        
        var btnX: CGFloat = 0.0
        var btnY: CGFloat = 0.0
        let btnW = (contentView.frame.size.width - configure.contentInset.left - configure.contentInset.right - CGFloat((configure.column - 1)) * configure.horizontalSpacing) / CGFloat(configure.column)
        let btnH = configure.height
        
        for (index, btn) in btns.enumerated() {
            btnX = CGFloat((index % configure.column)) * (btnW + configure.horizontalSpacing) + configure.contentInset.left
            btnY = CGFloat((index / configure.column)) * (btnH + configure.verticalSpacing) + configure.contentInset.top
            btn.frame = CGRect.init(x: btnX, y: btnY, width: btnW, height: btnH)
        }
        
        let lastBtn: SGTagButton = btns.last!
        let contentViewHeight = lastBtn.frame.maxY + configure.contentInset.bottom
        if isFixedHeight {
            if contentViewHeight < contentView.frame.size.height {
                contentView.contentSize = CGSize(width: contentView.frame.size.width, height: contentView.frame.size.height)
            } else {
                contentView.contentSize = CGSize(width: contentView.frame.size.width, height: contentViewHeight)
                contentView.showsVerticalScrollIndicator = configure.isShowsVerticalScrollIndicator
            }
        } else {
            contentView.frame.size.height = contentViewHeight
            frame.size.height = contentViewHeight
            if let tempHeightBlcok = heightBlock {
                tempHeightBlcok(self, contentViewHeight)
            }
        }
    }
}


// MARK: - 内部相关方法抽取
private extension SGTagsView {
    /// 计算字符串的宽度
    func calculateWidth(str: String, font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        let rect = (str as NSString).boundingRect(with: CGSize(width: 0, height: 0), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        return rect.size.width
    }
    /// 设置 UIButton 内部的 UIImageView 相对 UITitleLabel 的位置
    func setImage(btn: UIButton, imagePositionStyle: SGImagePositionStyle, spacing: CGFloat) {
        let imgView_width = btn.imageView?.frame.size.width
        let imgView_height = btn.imageView?.frame.size.height
        let titleLab_iCSWidth = btn.titleLabel?.intrinsicContentSize.width
        let titleLab_iCSHeight = btn.titleLabel?.intrinsicContentSize.height
        
        switch imagePositionStyle {
        case .left:
            if btn.contentHorizontalAlignment == .left {
                btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing, bottom: 0, right: 0)
            } else if btn.contentHorizontalAlignment == .right {
                btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: spacing)
            } else {
                let spacing_half = 0.5 * spacing;
                btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -spacing_half, bottom: 0, right: spacing_half)
                btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing_half, bottom: 0, right: -spacing_half)
            }
        case .right:
            let titleLabWidth = btn.titleLabel?.frame.size.width
            if btn.contentHorizontalAlignment == .left {
                btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleLabWidth! + spacing, bottom: 0, right: 0)
                btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imgView_width!, bottom: 0, right: 0)
            } else if btn.contentHorizontalAlignment == .right {
                btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -titleLabWidth!)
                btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: imgView_width! + spacing)
            } else {
                let imageOffset = titleLabWidth! + 0.5 * spacing
                let titleOffset = titleLabWidth! + 0.5 * spacing
                btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: imageOffset, bottom: 0, right: -imageOffset)
                btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -titleOffset, bottom: 0, right: titleOffset)
            }
        case .top:
            btn.imageEdgeInsets = UIEdgeInsets.init(top: -(titleLab_iCSHeight! + spacing), left: 0, bottom: 0, right: -titleLab_iCSWidth!)
            btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imgView_width!, bottom: -(imgView_height! + spacing), right: 0)
        case .bottom:
            btn.imageEdgeInsets = UIEdgeInsets.init(top: titleLab_iCSHeight! + spacing, left: 0, bottom: 0, right: -titleLab_iCSWidth!)
            btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imgView_width!, bottom: imgView_height! + spacing, right: 0)
        }
    }
    
    typealias LoadImageCompleteBlock = ((_ image: UIImage) -> ())?
    func loadImage(urlString: String, complete: LoadImageCompleteBlock) {
        let blockOperation = BlockOperation.init {
            let url = URL.init(string: urlString)
            guard let imageData = NSData(contentsOf: url!) else { return }
            let image = UIImage(data: imageData as Data)
            OperationQueue.main.addOperation {
                if complete != nil {
                    complete!(image!)
                }
            }
        }
        OperationQueue().addOperation(blockOperation)
    }
}
