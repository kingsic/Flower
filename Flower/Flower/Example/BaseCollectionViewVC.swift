//
//  BaseCollectionViewVC.swift
//  Flower
//
//  Created by kingsic on 2021/9/8.
//

import UIKit

class BaseCollectionViewVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "SGBaseCollectionView"
        // Do any additional setup after loading the view.
        
        
        let baseItem = SGBaseCollectionView()
        baseItem.frame = CGRect.init(x: 20, y: navBarHeight + 20, width: screenWidth - 40, height: 90)
        baseItem.backgroundColor = .green
        baseItem.itemSize = CGSize.init(width: 130, height: 80)
        view.addSubview(baseItem)
        baseItem.register(BaseItemsCell.self, reuseIdentifier: "BaseCellID")
        baseItem.delegate = self
        baseItem.dataSource = self
        baseItem.scrollDirectionHorizontal = true
        baseItem.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        baseItem.minimumLineSpacing = 20
        
        let baseItem1 = SGBaseCollectionView()
        baseItem1.frame = CGRect.init(x: 20, y: baseItem.frame.maxY + 20, width: screenWidth - 40, height: 90)
        baseItem1.backgroundColor = .green
        let w: CGFloat = screenWidth / 5
        baseItem1.itemSize = CGSize.init(width: w, height: w)
        view.addSubview(baseItem1)
        baseItem1.register(BaseItemsCell.self, reuseIdentifier: "BaseCellID")
        baseItem1.delegate = self
        baseItem1.dataSource = self
        baseItem1.scrollDirectionHorizontal = true
        baseItem1.pagingEnabled = true
        let s: CGFloat = 0.5 * (90 - w)
        baseItem.contentInset = UIEdgeInsets(top: s, left: 0, bottom: s, right: 0)
    }

}

extension BaseCollectionViewVC: SGBaseCollectionViewDataSource, SGBaseCollectionViewDelegate {
    func collectionView(_ baseCollectionView: SGBaseCollectionView, numberOfItems: Int) -> Int {
        return 6
    }
    
    func collectionView(_ baseCollectionView: SGBaseCollectionView, cell: UICollectionViewCell, cellForItemAt index: Int) {
        (cell as! BaseItemsCell).btn.setTitle("index - \(index)", for: .normal)
    }
    
    func collectionView(_ baseCollectionView: SGBaseCollectionView, didSelectItemAt index: Int) {
        print("当前点击的item下标值为：\(index)")
    }
}

class BaseItemsCell: UICollectionViewCell {
    var btn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        
        let height: CGFloat = 20
        let y: CGFloat = 0.5 * (frame.size.height - height)
        
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
