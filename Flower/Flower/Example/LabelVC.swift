//
//  LabelVC.swift
//  Flower
//
//  Created by kingsic on 2021/9/8.
//

import UIKit

class LabelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "SGLabel"
        // Do any additional setup after loading the view.
        
        let tempStr = "曾经沧海难为水，除却巫山不是云\n取次花丛懒回顾，半缘修道半缘君"
        
        let label = SGLabel.init()
        label.frame = CGRect.init(x: 20, y: navBarHeight + 20, width: screenWidth - 40, height: 200)
        label.backgroundColor = .green
        label.numberOfLines = 0
        label.text = tempStr
        view.addSubview(label)
        
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
