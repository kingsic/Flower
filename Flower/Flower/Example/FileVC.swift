//
//  FileVC.swift
//  FileVC
//
//  Created by kingsic on 2021/12/31.
//  Copyright © 2021 kingsic. All rights reserved.
//

import UIKit

class FileVC: UIViewController {
    
    lazy var dataSource = ["创建文件夹", "创建二级文件夹", "创建三级文件夹", "删除文件夹", "获取文件夹的大小", "保存数据", "获取数据", "添加新数据", "删除指定数据"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.separatorStyle = .none
    }

    var dict: Dictionary = [
        "array": [
            [
                "name": "Swift",
                "isSave": "false"
            ],
            [
                "name": "Objective-C",
                "isSave": "true"
            ]
        ]
    ]

}

extension FileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("测试单文件夹 - - \(FileTool.caches(name: "测试文件夹"))")
        } else if indexPath.row == 1 {
            print("测试双文件夹 - - \(FileTool.caches(name: "一级文件夹", subName: "二级文件夹"))")
        } else if indexPath.row == 2 {
            let filePath = FileTool.caches(name: "一级文件夹", subName: "二级文件夹", subSubName: "三级文件夹")
            print("filePath - - \(filePath)")
        } else if indexPath.row == 3 {
            let filePath = FileTool.caches(name: "一级文件夹", subName: "二级文件夹", subSubName: "三级文件夹")
            print("删除文件夹 - - \(FileTool.clean(name: filePath))")
        } else if indexPath.row == 4 {
            let filePath = FileTool.caches(name: "一级文件夹", subName: "二级文件夹", subSubName: "三级文件夹")
            let size = FileTool.size(name: filePath)
            print("文件夹大小 - - \(filePath) - - \(size) - - \(FileTool.conversion(size: UInt64(size)))")
        } else if indexPath.row == 5 {
            let filePath = FileTool.caches(name: "测试文件夹")
            let dataName = (filePath as NSString).appendingPathComponent("test.json")
            let result = (dict as NSDictionary).write(toFile: dataName, atomically: true)
            
            if result {
                print("数据保存成功")
            } else {
                print("数据保存失败")
            }
            print("fliePath - - \(filePath)")
        } else if indexPath.row == 6 {
            let filePath = FileTool.caches(name: "测试文件夹")
            let dataName = (filePath as NSString).appendingPathComponent("test.json")
            let dict = NSDictionary(contentsOfFile: dataName)
            print("data - - \(dict!)")
        } else if indexPath.row == 7 {
            var array: Array = dict["array"]!
            array.append(["name": "Flutter", "isSave": "false"])
            array.insert(["name": "Java", "isSave": "true"], at: 0)
            dict["array"] = array
            let filePath = FileTool.caches(name: "测试文件夹")
            let dataName = (filePath as NSString).appendingPathComponent("test.json")
            let result = (dict as NSDictionary).write(toFile: dataName, atomically: true)
            
            if result {
                print("更新数据成功")
            } else {
                print("更新数据失败")
            }
            let dict = NSDictionary(contentsOfFile: dataName)
            print("data - - \(dict!)")
        } else if indexPath.row == 8 {
            var array: Array = dict["array"]!
            array.remove(at: 0)
            dict["array"] = array
            let filePath = FileTool.caches(name: "测试文件夹")
            let dataName = (filePath as NSString).appendingPathComponent("test.json")
            let result = (dict as NSDictionary).write(toFile: dataName, atomically: true)
            
            if result {
                print("删除数据成功")
            } else {
                print("删除数据失败")
            }
            let dict = NSDictionary(contentsOfFile: dataName)
            print("data - - \(dict!)")
        }
    }
}

extension FileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    
}
