//
//  SGButton.swift
//  SGButton
//
//  Created by kingsic on 2021/11/23.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

public class UnHighlightedButton: UIButton {
    public override var isHighlighted: Bool {
        set {}
        get {return false}
    }
}

public class SpacingButton: UIButton {
    /// 文字距离左右边侧的距离，默认为 0
    /// 
    /// 如果右侧存在其他控件，使用 SnapKit 进行约束时，记得加上2倍的 spacing 宽度
    /// 
    /// 原因是：SnapKit 约束的调用时机要比 layoutSubviews 早
    public var spacing: CGFloat = 0
    
    public override func layoutSubviews() {
        super.layoutSubviews()
                
        if let tempText = titleLabel?.text {
            guard spacing > 0 else {
                return
            }
            
            let width = tempText.calculateStringWidth(font: (titleLabel?.font)!)
            frame.size.width = width + 2 * spacing
        }
    }
}

fileprivate extension String {
    /// Calculate the width of the string according to the font size
    ///
    /// - parameter font: UIFont
    ///
    /// - returns: The width of the calculated string
    func calculateStringWidth(font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        let tempRect = (self as NSString).boundingRect(with: CGSize(width: 0, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil)
        return tempRect.size.width
    }
}
