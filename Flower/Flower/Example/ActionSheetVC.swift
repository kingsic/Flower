//
//  ActionSheet.swift
//  Flower
//
//  Created by kingsic on 2022/2/6.
//

import UIKit

class ActionSheetVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let configure = SGActionSheetConfigure()
        configure.message = "您确定要退出吗？"
        let ASheet = SGActionSheet(titles: ["确定", "再想想"], configure: configure)
        ASheet.titlesClickBlock { actionSheet, index in
            print("index - - \(index)")
        }
        ASheet.setTitle(color: .red, index: 0)
        actionSheet(ASheet)
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
