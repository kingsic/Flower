//
//  CycleScrollViewVC.swift
//  Flower
//
//  Created by kingsic on 2022/12/19.
//

import UIKit

class CycleScrollViewVC: UIViewController {

    deinit {
        print("\(type(of: self)) - \(#function)")
    }
    
    let dataSource = ["SGCycleScrollView 支持主流轮播滚动", "像 UICollectionView 一样轻松使用", "完全支持自定义 Cell，不需要依赖任何第三方"]
    
    let xibDataSource = ["image_0", "image_1", "image_2"]

    @IBOutlet weak var XibCycleScrollView: SGCycleScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cycleScrollView()
        
        configXibCycleScrollView()
    }
    
    func cycleScrollView() {
        let cycleView = SGCycleScrollView()
        cycleView.backgroundColor = .red
        
        cycleView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: ceil(50.0))
        cycleView.delegate = self
        cycleView.dataSource = self
        cycleView.timeInterval = 3
        cycleView.scrollDirection = .vertical
        cycleView.isScrollEnabled = false
        view.addSubview(cycleView)
        cycleView.register(CycleScrollViewCell.self, reuseIdentifier: "")
    }
    
    func configXibCycleScrollView() {
        XibCycleScrollView.delegate = self
        XibCycleScrollView.dataSource = self
        XibCycleScrollView.timeInterval = 3
        XibCycleScrollView.register(XibCycleScrollViewCell.self, reuseIdentifier: "")
    }

}

extension CycleScrollViewVC: SGCycleScrollViewDelegate, SGCycleScrollViewDataSource {
    func cycleScrollView(_ cycleScrollView: SGCycleScrollView, didSelectItemAt index: Int) {
        print("index - - \(index)")
    }

    func numberOfItems(_ cycleScrollView: SGCycleScrollView) -> Int {
        return cycleScrollView == XibCycleScrollView ? xibDataSource.count : dataSource.count
    }
    
    func cycleScrollView(_ cycleScrollView: SGCycleScrollView, cell: UICollectionViewCell, cellForItemAt index: Int) {
        if cycleScrollView == XibCycleScrollView {
            let cell = cell as! XibCycleScrollViewCell
            cell.imgView.image = UIImage(named: xibDataSource[index])
        } else {
            let cell = cell as! CycleScrollViewCell
            cell.btn.setTitle(dataSource[index], for: .normal)
        }
    }
}

class CycleScrollViewCell: UICollectionViewCell {
    var btn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        btn.isUserInteractionEnabled = false
        btn.contentHorizontalAlignment = .left
        self.addSubview(btn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        btn.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btn_action() {
        print("btn_action")
    }
}

class XibCycleScrollViewCell: UICollectionViewCell {
    var imgView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imgView.contentMode = .scaleAspectFill
        self.addSubview(imgView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imgView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func btn_action() {
        print("btn_action")
    }
}
