//
//  ItemsViewVC.swift
//  Flower
//
//  Created by kingsic on 2021/9/8.
//

import UIKit

class ItemsViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "SGItemsView"
        // Do any additional setup after loading the view.
        
        let images = ["bg_image", "bg_image", "bg_image", "bg_image", "bg_image", "bg_image", "bg_image", "bg_image"]
        let items = SGItemsView()
        items.frame = CGRect.init(x: 20, y: navBarHeight + 20, width: screenWidth - 40, height: 70)
        items.backgroundColor = .green
        items.titles = ["粉丝", "喜欢", "我的", "评论", "粉丝", "喜欢", "我的", "评论"]
        items.itemSize = CGSize.init(width: 90, height: 70)
        items.scrollDirectionHorizontal = true
        items.configureImgViewBlock { imgView, index in
            imgView.image = UIImage.init(named: images[index])
        }
        view.addSubview(items)
        
        let images2 = ["bg_image", "bg_image", "bg_image", "bg_image", "bg_image", "bg_image", "bg_image", "bg_image"]
        let items2 = SGItemsView()
        items2.frame = CGRect.init(x: 20, y: items.frame.maxY + 20, width: screenWidth - 40, height: 170)
        items2.backgroundColor = .green
        items2.titles = ["粉丝", "喜欢", "我的", "评论", "粉丝", "喜欢", "我的", "评论"]
        items2.itemSize = CGSize.init(width: 90, height: 75)
        items2.configureImgViewBlock { imgView, index in
            imgView.image = UIImage.init(named: images2[index])
        }
        items2.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        view.addSubview(items2)
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
