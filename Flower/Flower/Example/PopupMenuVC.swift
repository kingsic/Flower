//
//  PopupMenuVC.swift
//  Flower
//
//  Created by kingsic on 2022/2/3.
//

import UIKit

class PopupMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green

        let btn = UIButton(type: .contactAdd)
        btn.frame = CGRect(x: 10, y: 200, width: 50, height: 50)
        btn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        view.addSubview(btn)
        
        let rightBtn = UIButton(type: .contactAdd)
        rightBtn.frame = CGRect(x: screenWidth - 60, y: 200, width: 50, height: 50)
        rightBtn.addTarget(self, action: #selector(rightBtn_action), for: .touchUpInside)
        view.addSubview(rightBtn)
    }

    @objc func btn_action(btn: UIButton) {
        let config = SGPopupMenuConfigure()
        config.point = CGPoint(x: btn.frame.minX + 3, y: btn.frame.maxY)
        config.triangleLocation = .Left
        config.width = 135
        config.imageViewBlock { imageView, index in
            imageView.image = UIImage(named: "image")
        }
        
        let vc = SGPopupMenu(configure: config)
        vc.dataSource = ["发起群聊", "添加朋友", "扫一扫", "收付款"]
        popupMenu(vc)
    }
    
    @objc func rightBtn_action(btn: UIButton) {
        let config = SGPopupMenuConfigure()
        config.point = CGPoint(x: btn.frame.maxX - config.width - 3, y: btn.frame.maxY)
        config.backgroundColor = .black.withAlphaComponent(0.2)
        config.color = .black.withAlphaComponent(0.5)
        config.separatorColor = .black.withAlphaComponent(0.6)
        config.separatorInset = .init(left: 15, right: 15)
        config.textColor = .white
        config.height = 50
        config.isTriangle = false
        
        let menu = SGPopupMenu(configure: config)
        menu.dataSource = ["发起群聊", "添加朋友", "扫一扫", "收付款"]
        menu.clickBlock { popupMenu, index in
            print("index - - \(index)")
        }
        popupMenu(menu)
    }
}
