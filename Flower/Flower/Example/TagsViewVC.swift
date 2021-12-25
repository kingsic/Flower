//
//  TagsViewVC.swift
//  Flower
//
//  Created by kingsic on 2021/9/8.
//

import UIKit

class TagsViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "SGTagsView"
        // Do any additional setup after loading the view.
        
        let tagsViewConfigure = SGTagsViewConfigure()
        tagsViewConfigure.selectedColor = .white
        tagsViewConfigure.selectedBackgroundColor = .black
        tagsViewConfigure.cornerRadius = 10
        tagsViewConfigure.style = .vertical

        let tagsView = SGTagsView.init(frame: CGRect.init(x: 20, y: navBarHeight + 20, width: screenWidth - 40, height: 200), configure: tagsViewConfigure)
        tagsView.tags = ["Objective-C", "Swift", "Flutter", "Java", "Kotlin"]
        tagsView.backgroundColor = .green
        tagsView.isFixedHeight = true
        view.addSubview(tagsView)
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
