//
//  SGTextView.swift
//  Flower
//
//  Created by kingsic on 2020/9/22.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

public class SGTextView: UITextView  {
    /// PlaceHolder
    public var placeHolder: String? {
        didSet {
            placeHolderLabel.text = placeHolder
        }
    }
    
    /// PlaceHolder Color
    public var placeHolderColor: UIColor? {
        didSet {
            placeHolderLabel.textColor = placeHolderColor
        }
    }
    
    /// Limit input words
    public var limitNumber: Int?
    
    /// PlaceHolder Label 
    private lazy var placeHolderLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.text = "请输入内容~"
        $0.textColor = UIColor.lightGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    public override var font: UIFont? {
        didSet {
            if font != nil {
                // 让在属性哪里修改的字体,赋给给我们占位label
                placeHolderLabel.font = font
            }
        }
    }
    
    public override var text: String? {
        didSet {
            // 根据文本是否有内容而显示占位label
            placeHolderLabel.isHidden = hasText
        }
    }
    
    // frame
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    // xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // 添加控件, 设置约束
    fileprivate func setupUI() {
        // 监听内容的通知
        NotificationCenter.default.addObserver(self, selector: #selector(SGTextView.valueChange), name: UITextView.textDidChangeNotification, object: nil)
        // UITextViewTextDidChangeNotification
        // 添加控件
        addSubview(placeHolderLabel)
        
        // 设置约束,使用系统的约束
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: placeHolderLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -10))
    }
    
    // 内容改变的通知方法
    @objc fileprivate func valueChange() {
        // 占位文字的显示与隐藏
        placeHolderLabel.isHidden = hasText
        
        // 字数限制处理
        if limitNumber != nil {

            guard limitNumber! > 0 else {
                return
            }
            
            if self.text!.count > limitNumber! {
                self.text = (self.text! as NSString).substring(to: limitNumber!)
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        // 设置占位文字的坐标
        placeHolderLabel.frame.origin.x = 5
        placeHolderLabel.frame.origin.y = 7
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

