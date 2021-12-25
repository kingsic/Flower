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
    /// - parameter dateFormat: 日期格式：yyyy-MM-dd HH:mm:ss（默认格式为：yyyy年MM月dd日）
    ///
    /// - parameter timeStamp: 时间戳
    ///
    /// - returns: 转换后的日期
    class func convert(dateFormat: String = "yyyy年MM月dd日", timeStamp: String) -> (string: String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let interval: TimeInterval = TimeInterval(timeStamp.prefix(10))!
        let date = Date(timeIntervalSince1970: interval)
        let dateString = dateFormatter.string(from: date as Date)

        return (dateString, date)
    }
    
    /// 当前时间
    ///
    /// - parameter dateFormat: 日期格式：yyyy-MM-dd HH:mm:ss（默认格式为：yyyy-MM-dd HH:mm:ss）
    ///
    /// - returns: 转换后的日期
    class func currentTime(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> (string: String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: Date())
        let date = dateFormatter.date(from: dateString)!
        return (dateString, date)
    }
    
    /// 时间比较
    ///
    /// - parameter dateFormat: 日期格式：yyyy-MM-dd HH:mm:ss（默认格式为：yyyy-MM-dd HH:mm:ss）
    ///
    /// - parameter time: 相比较时间
    ///
    /// - parameter otherTime: 相比较时间
    ///
    /// - returns: 比较后的结果（1：代表time大于otherTime；0：代表time等于otherTime；-1：代表time小于otherTime）
    class func compare(dateFormat: String = "yyyy-MM-dd HH:mm:ss", time: Date, otherTime: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let stringTime = dateFormatter.string(from: time)
        let date = dateFormatter.date(from: stringTime)
        
        let stringOtherTime = dateFormatter.string(from: otherTime)
        let otherDate = dateFormatter.date(from: stringOtherTime)
        
        let result: ComparisonResult = date!.compare(otherDate!)
        if result == .orderedDescending { // time 大于 otherTime
            return 1
        } else if result == .orderedAscending { // time 小于 otherTime
            return -1
        } else { // 完全相等
            return 0
        }
    }
}

