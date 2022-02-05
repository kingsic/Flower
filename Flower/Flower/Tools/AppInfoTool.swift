//
//  AppInfoTool.swift
//  Flower
//
//  Created by kingsic on 2021/11/23.
//

import UIKit

class AppInfoTool: NSObject {
    /// Get the app name
    ///
    /// - returns: App name
    public class func appName() -> String {
        var appName = Bundle.main.infoDictionary?["CFBundleName"]
        if appName == nil {
            appName = Bundle.main.infoDictionary?["CFBundleDisplayName"]
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
    
}
