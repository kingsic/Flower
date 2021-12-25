//
//  SGDragView.swift
//  SGDragView
//
//  Created by kingsic on 2021/12/16.
//  Copyright © 2021 kingsic. All rights reserved.
//

import UIKit

public enum SGDragViewTop {
    case `default`
    case statusBar
    case navigationBar
}

public enum SGDragViewBottom {
    case `default`
    case safeArea
    case tabBar
}


public class SGDragView: UIView {
    /// 距离顶部的距离
    public var topDistance: SGDragViewTop = .default
    
    /// 距离底部的距离
    public var bottomDistance: SGDragViewBottom = .default

    /// 吸附到左右边侧需要的时间
    public var animateDuration: Double = 0.25
    
    
    /// 记录开始点
    fileprivate var beganPoint: CGPoint = .zero
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first
        beganPoint = (touch?.location(in: self))!
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let currentPoint = touch.location(in: self)
        
        let offsetX = currentPoint.x - beganPoint.x
        let offsetY = currentPoint.y - beganPoint.y

        center = CGPoint(x: center.x + offsetX, y: center.y + offsetY)
        
        let superViewSize = superview?.frame.size
        let selfSize = frame.size

        if center.x > (superViewSize?.width)! - selfSize.width * 0.5 {
            let x = (superViewSize?.width)! - selfSize.width * 0.5
            center = CGPoint(x: x, y: center.y + offsetY)
        } else if (center.x < selfSize.width * 0.5) {
            let x = selfSize.width * 0.5
            center = CGPoint(x: x, y: center.y + offsetY)
        }
        
        if center.y > (superViewSize?.height)! - selfSize.height * 0.5 - bottom_y() {
            let y = (superViewSize?.height)! - selfSize.height * 0.5 - bottom_y()
            center = CGPoint(x: center.x, y: y)
        } else if center.y < selfSize.height * 0.5 + top_y() {
            let y = selfSize.height * 0.5 + top_y()
            center = CGPoint(x: center.x, y: y)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let superViewSize = superview?.frame.size
        let selfSize = frame.size
        let y = self.center.y - 0.5 * selfSize.height

        if center.x >= (superViewSize?.width)! * 0.5 {
            UIView.animate(withDuration: animateDuration) {
                let x = superViewSize!.width - selfSize.width
                self.frame = CGRect(x: x, y: y, width: selfSize.width, height: selfSize.height)
            }
        } else {
            UIView.animate(withDuration: animateDuration) {
                self.frame = CGRect(x: 0, y: y, width: selfSize.width, height: selfSize.height)
            }
        }
    }
    
    private func top_y() -> CGFloat {
        if topDistance == .default {
            return 0
        } else if topDistance == .statusBar {
            return SGDragView.statusBarHeight
        } else {
            return SGDragView.navBarHeight
        }
    }
    
    private func bottom_y() -> CGFloat {
        if bottomDistance == .default {
            return 0
        } else if bottomDistance == .safeArea {
            return SGDragView.safeAreaInsetBottom
        } else {
            return SGDragView.tabBarHeight
        }
    }

}


fileprivate extension SGDragView {
    /// Gets status bar height
    static var statusBarHeight: CGFloat {
        if #available(iOS 13, *) {
            return (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height)!
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    /// Gets navigation bar height
    static var navBarHeight: CGFloat { return statusBarHeight + 44 }
    
    /// Gets tab bar height
    static var tabBarHeight: CGFloat { return statusBarHeight == 20 ? 49 : 83 }
    
    /// Gets bottom safeArea height
    static var safeAreaInsetBottom: CGFloat { return statusBarHeight == 20 ? 0 : 34 }
}
