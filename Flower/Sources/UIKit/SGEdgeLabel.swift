//
//  SGLabel.swift
//  SGLabel
//
//  Created by kingsic on 2020/12/20.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

public struct SGEdgeInsets {
    public var top: CGFloat = 10.0
    public var left: CGFloat = 0.0
    public var right: CGFloat = 0.0
}

public extension SGEdgeInsets {
    static let zero: SGEdgeInsets = SGEdgeInsets()
}

public class SGEdgeLabel: UILabel {
    /// 文本内边距
    public var contentInset: SGEdgeInsets = .zero

    public override func drawText(in rect: CGRect) {
        let tempRect = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: tempRect)
    }

    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect: CGRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let offsetLeft = contentInset.left < 0 ? 0 : contentInset.left
        let offsetRight = contentInset.right < 0 ? 0 : contentInset.right
        let offsetTop = contentInset.top < 0 ? 0 : contentInset.top

        rect.origin.x = offsetLeft
        rect.origin.y = offsetTop
        rect.size.width -= offsetLeft + offsetRight
        return rect
    }

    
}
