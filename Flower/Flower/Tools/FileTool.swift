//
//  FileTool.swift
//  FileTool
//
//  Created by kingsic on 2021/11/17.
//  Copyright © 2021 kingsic. All rights reserved.
//

import UIKit

public class FileTool: NSObject {
    /// 获取亦或是创建 Caches 文件夹下的文件夹
    ///
    /// - parameter name：文件夹名称
    public class func caches(name: String) -> String {
        let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let filePath = "\(cachesPath!)/\(name)"
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath, isDirectory: nil) {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            return filePath
        } else {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            return filePath
        }
    }
    
    /// 获取亦或是创建 Caches 文件夹下的文件夹下的文件夹
    ///
    /// - parameter name：文件夹名称
    ///
    /// - parameter subName：二级文件夹名称
    public class func caches(name: String, subName: String) -> String {
        let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let filePath = "\(cachesPath!)/\(name)/\(subName)"
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath, isDirectory: nil) {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            return filePath
        } else {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            return filePath
        }
    }
    
    /// 获取亦或是创建 Caches 文件夹下的文件夹下的文件夹
    ///
    /// - parameter name：文件夹名称
    ///
    /// - parameter subName：二级文件夹名称
    ///
    /// - parameter subSubName：三级文件夹名称
    public class func caches(name: String, subName: String, subSubName: String) -> String {
        let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let filePath = "\(cachesPath!)/\(name)/\(subName)/\(subSubName)"
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath, isDirectory: nil) {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            return filePath
        } else {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            return filePath
        }
    }
    
    /// 移除文件夹
    public class func clean(name: String) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: name)
        } catch {
            
        }
    }
    
    /// 计算文件夹的大小
    public class func size(name: String) -> UInt64 {
        var size: UInt64 = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: name, isDirectory: &isDir)
        // 判断文件存在
        if isExists {
            // 是否为文件夹
            if isDir.boolValue {
                // 迭代器 存放文件夹下的所有文件名
                let enumerator = fileManager.enumerator(atPath: name)
                for subPath in enumerator! {
                    // 获得全路径
                    let fullPath = name.appending("/\(subPath)")
                    do {
                        let attr = try fileManager.attributesOfItem(atPath: fullPath)
                        size += attr[FileAttributeKey.size] as! UInt64
                    } catch  {
                        print("error :\(error)")
                    }
                }
            } else { // 单文件
                do {
                    let attr = try fileManager.attributesOfItem(atPath: name)
                    size += attr[FileAttributeKey.size] as! UInt64
                } catch  {
                    print("error :\(error)")
                }
            }
        }
        return size
    }
    
    /// 文件夹大小格式转换
    public class func conversion(size: UInt64) -> String {
        if size < 1024 {
            return String(format: "%.2fB", Double(size))
        } else if size >= 1024 && size < (1024 * 1024) {
            return String(format: "%.2fKB", Double(size / 1024))
        } else if size >= (1024 * 1024) && size < (1024 * 1024 * 1024) {
            return String(format: "%.2fMB", Double(size / (1024 * 1024)))
        } else {
            return String(format: "%.2fGB", Double(size / (1024 * 1024 * 1024)))
        }
    }
    
}
