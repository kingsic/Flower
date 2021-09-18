//
//  GCDAsync.swift
//  GCDAsync
//
//  Created by kingsic on 2020/12/31.
//  Copyright © 2020 kingsic. All rights reserved.
//

import Foundation

public typealias Task = () -> Void

public struct GCDAsync {
    /// 延迟函数
    @discardableResult
    public static func delay(_ time: Double, _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: item)
        return item
    }
    
    /// 异步延迟函数
    ///
    /// - parameter time:       延迟时间
    /// - parameter task:       延迟执行任务
    @discardableResult
    public static func asyncDelay(_ time: Double, _ task: @escaping Task) -> DispatchWorkItem {
        _asyncDelay(time, task)
    }
    
    /// 异步延迟函数执行完后再回到主线程
    ///
    /// - parameter time:       延迟时间
    /// - parameter task:       延迟执行任务
    /// - parameter mainTask:   主线程执行任务
    @discardableResult
    public static func asyncDelay(_ time: Double, _ task: @escaping Task, mainTask: @escaping Task) -> DispatchWorkItem {
        _asyncDelay(time, task, mainTask)
    }
    
    /// 异步执行函数
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    /// 异步执行函数后再回到主线程
    ///
    /// - parameter task:       异步执行任务
    /// - parameter mainTask:   主线程执行任务
    public static func async(_ task: @escaping Task, mainTask: @escaping Task) {
        _async(task, mainTask)
    }
}

// MARK: 内部方法
private extension GCDAsync {
    /// 异步函数
    ///
    /// - parameter block:      异步执行任务
    /// - parameter mainTask:   主线程执行任务
    private static func _async(_ block: @escaping Task, _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    /// 异步延迟函数
    ///
    /// - parameter block:      异步执行任务
    /// - parameter mainTask:   主线程执行任务
    private static func _asyncDelay(_ time: Double, _ block: @escaping Task, _ mainTask: Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.global().asyncAfter(deadline: .now() + time, execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}

