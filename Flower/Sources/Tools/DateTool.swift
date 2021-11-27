//
//  DateTool.swift
//  Flower
//
//  Created by kingsic on 2021/11/1.
//

import Foundation

class DateTool: NSObject {
    /// 时间戳转换日期
    ///
    /// - parameter timeStamp: 时间戳
    /// - parameter dateFormat: 转换后的日期格式：yyyy-MM-dd HH:mm:ss（默认格式为：yyyy年MM月dd日）
    ///
    /// - returns: 转换后的日期
    class func convert(timeStamp: String, dateFormat: String = "yyyy年MM月dd日") -> String {
        let interval: TimeInterval = TimeInterval(timeStamp.prefix(10))!
        let date = Date(timeIntervalSince1970: interval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        return dateformatter.string(from: date as Date)
    }
}

