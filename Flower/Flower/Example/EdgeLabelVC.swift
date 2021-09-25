//
//  LabelVC.swift
//  Flower
//
//  Created by kingsic on 2021/9/8.
//

import UIKit

class EdgeLabelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "SGEdgeLabel"
        // Do any additional setup after loading the view.
        
        let tempStr = "曾经沧海难为水，除却巫山不是云，取次花丛懒回顾，半缘修道半缘君\n曾经沧海难为水，除却巫山不是云，取次花丛懒回顾，半缘修道半缘君"
        
        let label = SGEdgeLabel.init()
        label.frame = CGRect.init(x: 20, y: navBarHeight + 20, width: screenWidth - 40, height: 130)
        label.backgroundColor = .green
        label.numberOfLines = 0
        label.contentInset = SGEdgeInsets(top: 10, left: 10, right: 10)
        label.text = tempStr
        view.addSubview(label)
        
        let lab = UILabel.init()
        lab.frame = CGRect.init(x: 20, y: label.frame.maxY + 20, width: screenWidth - 40, height: 130)
        lab.backgroundColor = .green
        lab.numberOfLines = 0
        lab.text = tempStr
        view.addSubview(lab)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
