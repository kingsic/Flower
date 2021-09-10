//
//  TextViewVC.swift
//  Flower
//
//  Created by kingsic on 2021/9/8.
//

import UIKit

class TextViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "SGTextView"
        // Do any additional setup after loading the view.
                
        let textView = SGTextView()
        textView.frame = CGRect.init(x: 20, y: navBarHeight + 20, width: screenWidth - 40, height: 200)
        textView.backgroundColor = .green
        textView.placeHolder = "请输入你想要表达的内容"
        textView.placeHolderColor = .red
        textView.limitNumber = 7
        view.addSubview(textView)
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
