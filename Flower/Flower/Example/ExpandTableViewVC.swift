//
//  ExpandTableViewVC.swift
//  ExpandTableViewVC
//
//  Created by kingsic on 2022/1/21.
//

import UIKit

class ExpandTableViewVC: UIViewController {

    var dataSource: Array = [Any]()
    var sectionIndex: Array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)

        let arr = ["Swift", "Objective-C"]
        let arr1 = ["Swift", "Objective-C", "Flutter"]

        dataSource.append(arr)
        dataSource.append(arr1)
        
        dataSource.forEach { _ in
            sectionIndex.append("1")
        }
        
        tableView.reloadData()
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tv.bounces = false
        return tv
    }()
}

extension ExpandTableViewVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array: Array = dataSource[section] as! Array<Any>
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let array: Array = dataSource[indexPath.section] as! Array<Any>
        cell.textLabel?.text = (array[indexPath.row] as! String)
        cell.backgroundColor = .red
        return cell
    }
}

extension ExpandTableViewVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempView = UIView()
        tempView.backgroundColor = .green
        
        let rightBtn = UIButton(type: .custom)
        rightBtn.addTarget(self, action: #selector(section_rightBtn_action), for: .touchUpInside)
        rightBtn.frame = CGRect(x: UIScreen.main.bounds.size.width - 100, y: 0, width: 100, height: 52)
        rightBtn.setTitle("点我啊", for: .normal)
        rightBtn.backgroundColor = .black
        rightBtn.tag = section
        tempView.addSubview(rightBtn)

        let leftBtn = UIButton(type: .custom)
        leftBtn.contentHorizontalAlignment = .left
        leftBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        leftBtn.setTitle("第\(section + 1)章", for: .normal)
        leftBtn.setTitleColor(.red, for: .normal)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 52)
        tempView.addSubview(leftBtn)
        return tempView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sectionIndex[indexPath.section] as NSString).isEqual(to: "0") {
            return 0
        } else {
            return 66
        }
    }
    
    
    @objc func section_rightBtn_action(btn: UIButton) {
        btn.isSelected = !btn.isSelected

        let tempIndex = btn.tag
        let tempArr: Array = dataSource[tempIndex] as! Array<Any>
        var indexArray: Array<IndexPath> = []
        
        for (index, _) in tempArr.enumerated() {
            let indexPath = NSIndexPath(row: index, section: tempIndex)
            indexArray.append(indexPath as IndexPath)
        }
        
        if (sectionIndex[tempIndex] as NSString).isEqual(to: "0") {
            sectionIndex[tempIndex] = "1"
            tableView.reloadRows(at: indexArray, with: UITableView.RowAnimation.none)
        } else {
            sectionIndex[tempIndex] = "0"
            tableView.reloadRows(at: indexArray, with: UITableView.RowAnimation.none)
        }
    }
}

