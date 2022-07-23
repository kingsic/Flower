//
//  SGDashedlineView.swift
//  SGDashedlineView
//
//  Created by kingsic on 2022/6/30.
//

import UIKit

enum Direction {
    case horizontal, vertical
}

class SGDashedlineView: UIView {

    // 虚线的方向，默认为水平
    var direction: Direction = .horizontal
    
    // 虚线的颜色，默认为红色
    var color: UIColor = .red
    
    // 虚线的宽度，默认为1.0
    var width: CGFloat = 1.0
    
    // 虚线的长度，默认为5.0
    var length: CGFloat = 5.0
    
    // 虚线的间距，默认为5.0
    var spacing: CGFloat = 5.0
    

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(color.cgColor)
        context?.setLineWidth(width)
        
        if direction == .horizontal {
            let offsetY = 0.5 * frame.size.height
            let width = frame.size.width
            context?.move(to: CGPoint(x: 0, y: offsetY))
            context?.addLine(to: CGPoint(x: width, y: offsetY))
        } else {
            let offsetX = 0.5 * frame.size.width
            let height = frame.size.height
            context?.move(to: CGPoint(x: offsetX, y: 0))
            context?.addLine(to: CGPoint(x: offsetX, y: height))
        }
        
        // 虚线的长和间距
        let arr: [CGFloat] = [length, spacing]
        context?.setLineDash(phase: 0, lengths: arr)
        context?.drawPath(using: .stroke)
    }
    
}
