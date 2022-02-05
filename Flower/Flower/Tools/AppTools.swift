//
//  AppTools.swift
//  AppTools
//
//  Created by kingsic on 2020/8/19.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

public let screenWidth = UIScreen.main.bounds.size.width
public let screenHeight = UIScreen.main.bounds.size.height
public let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height
public let navBarHeight = statusBarHeight! + 44
public let tabBarHeight = statusBarHeight! == 20 ? 49 : 83
/// 安全边界到底部的距离
public let safeAreaInsetsBottom = statusBarHeight == 20 ? 0 : 34;


public class AppTools: NSObject {
    /// After processing the hidden navigation bar, the scrollView offsets the status bar height downward
    ///
    /// - parameter scrollView: ScrollView
    ///
    /// - parameter controller: Controller of Scrollview
    public class func adjust(scrollView: UIScrollView, controller: UIViewController) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            controller.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    /// Make a call
    ///
    /// - parameter number: Telephone number
    public class func callPhone(number: String) {
        let phoneNum = "telprompt://\(number)"
        guard let url = URL.init(string: phoneNum) else { return }
        UIApplication.shared.open(url, options: Dictionary(), completionHandler: nil)
    }
    
}

