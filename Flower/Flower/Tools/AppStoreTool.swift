//
//  AppStoreTool.swift
//  Flower
//
//  Created by kingsic on 2021/11/23.
//

import UIKit

class AppStoreTool: NSObject {
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
    
}
