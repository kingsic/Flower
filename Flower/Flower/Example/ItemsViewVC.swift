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
        items.contentInsetTop = 11
        items.itemClickBlock { index in
            print("index - \(index)")
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
        items2.setItemTitle(color: .red, index: 2)
        
        
        let baseItem = SGBaseItemsView()
        baseItem.frame = CGRect.init(x: 20, y: items2.frame.maxY + 20, width: screenWidth - 40, height: 90)
        baseItem.backgroundColor = .green
        baseItem.itemSize = CGSize.init(width: 130, height: 80)
        view.addSubview(baseItem)
        baseItem.register(BaseItemsCell.self, reuseIdentifier: "BaseCellID")
        baseItem.delegate = self
        baseItem.dataSource = self
        baseItem.scrollDirectionHorizontal = true
        baseItem.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        baseItem.minimumLineSpacing = 20
    }

}

extension ItemsViewVC: SGBaseItemsViewDataSource, SGBaseItemsViewDelegate {
    func itemsView(_ itemsView: SGBaseItemsView, numberOfItems: Int) -> Int {
        return 6
    }
    
    func itemsView(_ itemsView: SGBaseItemsView, didSelectItemAt index: Int) {
        print("当前点击的item下标值为：\(index)")
    }
}

class BaseItemsCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        
        let height: CGFloat = 20
        let y: CGFloat = 0.5 * (frame.size.height - height)
        
        let btn = UIButton()
        btn.frame = CGRect(x: 10, y: y, width: frame.size.width - 20, height: height)
        btn.setTitle("btn", for: .normal)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        self.addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btn_action() {
        print("btn_action")
    }
}
