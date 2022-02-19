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
        btn.frame = CGRect(x: 10, y: 100, width: 50, height: 50)
        btn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        btn.tag = 0
        view.addSubview(btn)
        
        let centerBtn = UIButton(type: .contactAdd)
        centerBtn.frame = CGRect(x: 0.5 * (screenWidth - 50), y: 100, width: 50, height: 50)
        centerBtn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        centerBtn.tag = 1
        view.addSubview(centerBtn)
        
        let rightBtn = UIButton(type: .contactAdd)
        rightBtn.frame = CGRect(x: screenWidth - 60, y: 100, width: 50, height: 50)
        rightBtn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        rightBtn.tag = 2
        view.addSubview(rightBtn)
        
        let bottomBtn = UIButton(type: .contactAdd)
        bottomBtn.frame = CGRect(x: 10, y: 300, width: 50, height: 50)
        bottomBtn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        bottomBtn.tag = 3
        view.addSubview(bottomBtn)
        
        let bottomCenterBtn = UIButton(type: .contactAdd)
        bottomCenterBtn.frame = CGRect(x: 0.5 * (screenWidth - 50), y: 300, width: 50, height: 50)
        bottomCenterBtn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        bottomCenterBtn.tag = 4
        view.addSubview(bottomCenterBtn)
        
        let bottomRightBtn = UIButton(type: .contactAdd)
        bottomRightBtn.frame = CGRect(x: screenWidth - 60, y: 300, width: 50, height: 50)
        bottomRightBtn.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
        bottomRightBtn.tag = 5
        view.addSubview(bottomRightBtn)
    }

    @objc func btn_action(btn: UIButton) {
        if btn.tag == 1 {
            let config = SGPopupMenuConfigure()
            config.point = CGPoint(x: 0.5 * (screenWidth - config.width), y: btn.frame.maxY)
            config.backgroundColor = .black.withAlphaComponent(0.2)
            config.color = .black.withAlphaComponent(0.5)
            config.separatorColor = .black.withAlphaComponent(0.6)
            config.separatorInset = .init(left: 15, right: 15)
            config.textColor = .white
            config.textAlignment = .center
            config.height = 50
            
            let menu = SGPopupMenu(configure: config)
            menu.dataSource = ["发起群聊", "添加朋友", "扫一扫", "收付款"]
            menu.clickBlock { popupMenu, index in
                print("index - - \(index)")
            }
            popupMenu(menu)
        } else if btn.tag == 2 {
            let config = SGPopupMenuConfigure()
            config.point = CGPoint(x: btn.frame.maxX - config.width - 3, y: btn.frame.maxY)
            config.backgroundColor = .black.withAlphaComponent(0.2)
            config.separatorColor = .black.withAlphaComponent(0.6)
            config.separatorInset = .init(left: 15, right: 15)
            config.triangleLocation = .topRight
            config.width = 135
            config.imageViewBlock { imageView, index in
                imageView.image = UIImage(named: "image")
            }
            
            let menu = SGPopupMenu(configure: config)
            menu.dataSource = ["发起群聊", "添加朋友", "扫一扫", "收付款"]
            menu.clickBlock { popupMenu, index in
                print("index - - \(index)")
            }
            popupMenu(menu)
        } else if btn.tag == 3 {
            let config = SGPopupMenuConfigure()
            config.point = CGPoint(x: btn.frame.minX + 3, y: btn.frame.maxY - 4 * 44 - 60)
            config.triangleLocation = .topLeft
            config.width = 135
            config.triangleLocation = .bottomLeft
            config.imageViewBlock { imageView, index in
                imageView.image = UIImage(named: "image")
            }
            
            let vc = SGPopupMenu(configure: config)
            vc.dataSource = ["发起群聊", "添加朋友", "扫一扫", "收付款"]
            popupMenu(vc)
        } else if btn.tag == 4 {
            let config = SGPopupMenuConfigure()
            config.point = CGPoint(x: 0.5 * (screenWidth - config.width), y: btn.frame.maxY - 4 * 50 - 60)
            config.backgroundColor = .black.withAlphaComponent(0.2)
            config.color = .black.withAlphaComponent(0.5)
            config.separatorColor = .black.withAlphaComponent(0.6)
            config.separatorInset = .init(left: 15, right: 15)
            config.textColor = .white
            config.height = 50
            config.triangleLocation = .bottomCenter
            
            let menu = SGPopupMenu(configure: config)
            menu.dataSource = ["发起群聊", "添加朋友", "扫一扫", "收付款"]
            menu.clickBlock { popupMenu, index in
                print("index - - \(index)")
            }
            popupMenu(menu)
        } else if btn.tag == 5 {
            let config = SGPopupMenuConfigure()
            config.point = CGPoint(x: btn.frame.maxX - config.width - 3, y: btn.frame.maxY - 4 * 44 - 50)
            config.backgroundColor = .black.withAlphaComponent(0.2)
            config.separatorColor = .black.withAlphaComponent(0.6)
            config.separatorInset = .init(left: 15, right: 15)
            config.triangleLocation = .bottomRight
            config.isTriangle = false
            
            let menu = SGPopupMenu(configure: config)
            menu.dataSource = ["发起群聊", "添加朋友", "扫一扫", "收付款"]
            menu.clickBlock { popupMenu, index in
                print("index - - \(index)")
            }
            popupMenu(menu)
        } else {
            let config = SGPopupMenuConfigure()
            config.point = CGPoint(x: btn.frame.minX + 3, y: btn.frame.maxY)
            config.triangleLocation = .topLeft
            config.width = 135
            config.imageViewBlock { imageView, index in
                imageView.image = UIImage(named: "image")
            }
            
            let vc = SGPopupMenu(configure: config)
            vc.dataSource = ["发起群聊", "添加朋友", "扫一扫", "收付款"]
            popupMenu(vc)
        }

    }

}
