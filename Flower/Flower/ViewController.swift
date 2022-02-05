//
//  ViewController.swift
//  Flower
//
//  Created by kingsic on 2021/9/7.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = [
        ["SGEdgeLabel": EdgeLabelVC.self],
        ["ExpandTableView": ExpandTableViewVC.self],        
        ["SGItemsView": ItemsViewVC.self],
        ["SGPopupMenu": PopupMenuVC.self],
        ["SGTagsView": TagsViewVC.self],
        ["SGTextView": TextViewVC.self],
        ["文件数据储存相关": FileVC.self]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.tableFooterView = UIView()
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = dataSource[indexPath.row].values.first
        if let tempVC = vc {
            navigationController?.pushViewController(tempVC.init(), animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.text = dataSource[indexPath.row].keys.first
        return cell
    }
}

