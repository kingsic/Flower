//
//  SGLabel.swift
//  SGLabel
//
//  Created by kingsic on 2020/12/20.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

class SGLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let tempRect = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: tempRect)
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bounds.origin.y
        return textRect
    }
    
    
}
