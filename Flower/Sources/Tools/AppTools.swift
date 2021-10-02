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
    /// Get the app name
    ///
    /// - returns: App name
    public class func appName() -> String {
        var appName = Bundle.main.infoDictionary?["CFBundleDisplayName"]
        if appName == nil {
            appName = Bundle.main.infoDictionary?["CFBundleName"]
        }
        return appName as! String
    }
    /// Get the app version number
    ///
    /// - returns: App version number
    public class func appVersion() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        return appVersion as! String
    }
    /// Get the app build version number
    ///
    /// - returns: App build version number
    public class func appBuildVersion() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleVersion"]
        return appVersion as! String
    }

    /// Jump to app store
    ///
    /// - parameter appID: App ID
    public class func jumptoAppStore(appID: String) {
        let string = "https://itunes.apple.com/app/apple-store/id\(appID)?mt=8"
        guard let url = URL.init(string: string) else { return }
        UIApplication.shared.open(url, options: Dictionary.init()) { (success: Bool) in

        }
    }
    public typealias WriteReviewCompletionBlock = ((Bool) -> ())?
    /// Jump to app store to write a review
    ///
    /// - parameter appID: App ID
    public class func jumptoAppStoreWriteReview(appID: String, completionBlock: WriteReviewCompletionBlock) {
        let string = "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review"
        guard let url = URL.init(string: string) else { return }
        UIApplication.shared.open(url, options: Dictionary.init()) { (success: Bool) in
            if completionBlock != nil {
                completionBlock!(success)
            }
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

