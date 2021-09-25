//
//  SGItemsView.swift
//  SGItemsView
//
//  Created by kingsic on 2020/10/23.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

public class SGItemsView: UIView {
    /// Item titles
    public var titles: Array<Any>?
    
    /// Title font，default system font 12 plain
    public var titleFont: UIFont = .systemFont(ofSize: 12)
    
    /// Title color，default black
    public var titleColor: UIColor = .black
    
    public typealias ConfigureImgViewBlock = (_ imageView: UIImageView, _ index: Int) -> Void
    private var tempConfigureImgViewBlock: ConfigureImgViewBlock?
    /// Configure imageView callback method, leave the imageView to external processing, such as network or local loading image
    public func configureImgViewBlock(imgViewBlock: @escaping ConfigureImgViewBlock) {
        tempConfigureImgViewBlock = imgViewBlock
    }
    
    /// Item size. consider the top and bottom values of the contentinset property when setting the height
    public var itemSize: CGSize?
    
    /// Item content Inset of top, defalut is 5.0
    ///
    /// The maximum value cannot exceed 1/6 of itemSize
    public var contentInsetTop: CGFloat = 5.0
    
    /// Item content Inset of bottom, defalut is 5.0
    ///
    /// The maximum value cannot exceed 1/6 of itemSize
    public var contentInsetBottom: CGFloat = 5.0

    /// Item space between image and title, defalut is 5.0
    ///
    /// The maximum value cannot exceed 1/6 of itemSize
    public var spacing: CGFloat = 5.0
    
    /// Default UIEdgeInsetsZero. add additional scroll area around content
    public var contentInset: UIEdgeInsets {
        set {
            collectionView.contentInset = UIEdgeInsets.init(top: newValue.top, left: newValue.left, bottom: newValue.bottom, right: newValue.right)
        }
        get {
            return .zero
        }
    }
    
    /// Default false. if true, stop on multiples of view bounds
    public var pagingEnabled: Bool {
        set {
            if newValue {
                collectionView.isPagingEnabled = newValue
            }
        }
        get {
            return false
        }
    }
    
    /// Default false. if true, scroll direction Horizontal
    public var scrollDirectionHorizontal: Bool? {
        willSet {
            if newValue == true {
                CVFLayout.scrollDirection = .horizontal
            }
        }
    }
    
    /// Default false. if true, show indicator while we are tracking. fades out after tracking
    public var showsHorizontalScrollIndicator: Bool {
        set {
            if newValue == true {
                collectionView.showsHorizontalScrollIndicator = true
            }
        }
        get {
            return false
        }
    }
    
    public typealias ItemClickBlock = (_ index: Int) -> Void
    private var tempItemClickBlock: ItemClickBlock?
    /// Item click callback method
    public func itemClickBlock(itemClick: ItemClickBlock?) {
        tempItemClickBlock = itemClick
    }
    
    var itemTitleColorDict = [String: UIColor]()
    /// Set the titleColor of item according to the subscript
    public func setItemTitle(color: UIColor, index: Int) {
        itemTitleColorDict["\(index)"] = color
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let tempItemSize = itemSize {
            CVFLayout.itemSize = CGSize(width: tempItemSize.width, height: tempItemSize.height)
        }
        
        let cv_x: CGFloat = 0.0
        let cv_y: CGFloat = 0.0
        let cv_w = self.frame.size.width
        let cv_h = self.frame.size.height
        collectionView.frame = CGRect.init(x: cv_x, y: cv_y, width: cv_w, height: cv_h)
    }
    
    private lazy var CVFLayout: UICollectionViewFlowLayout = {
        let tempCVFLayout = UICollectionViewFlowLayout()
        tempCVFLayout.minimumLineSpacing = 0
        tempCVFLayout.minimumInteritemSpacing = 0
        return tempCVFLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let tempCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CVFLayout)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.register(SGItemCell.self, forCellWithReuseIdentifier: "cellID")
        tempCollectionView.backgroundColor = self.backgroundColor
        tempCollectionView.showsHorizontalScrollIndicator = false
        return tempCollectionView
    }()
    
    
}

extension SGItemsView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! SGItemCell
        if let configureImgViewBlock = tempConfigureImgViewBlock {
            configureImgViewBlock(cell.imgView, indexPath.item)
        }
        cell.contentInsetOfTop = contentInsetTop
        cell.contentInsetOfBottom = contentInsetBottom
        cell.spacing = spacing
        cell.titleLab.text = (titles?[indexPath.item] as! String)
        cell.titleLab.font = titleFont
        cell.titleLab.textColor = titleColor
        if !itemTitleColorDict.isEmpty {
            for (key, value) in itemTitleColorDict {
                if Int(key) == indexPath.item {
                    cell.titleLab.textColor = value
                }
            }
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let itemClickBlock = tempItemClickBlock {
            itemClickBlock(indexPath.item)
        }
    }
}


private class SGItemCell: UICollectionViewCell {
    public var contentInsetOfTop: CGFloat = 0.0
    public var contentInsetOfBottom: CGFloat = 0.0
    public var spacing: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
        addSubview(titleLab)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let max_v: CGFloat = 6
        
        if contentInsetOfTop > self.frame.size.height / max_v {
            contentInsetOfTop = 0.0
        }
        if contentInsetOfBottom >  self.frame.size.height / max_v {
            contentInsetOfBottom = 0.0
        }
        if spacing > self.frame.size.height / max_v {
            spacing = 0.0
        }
        
        let lab_height = titleLab.text!.calculateStringHeight(width: self.frame.size.width, font: titleLab.font)
        let img_height: CGFloat = self.frame.size.height - contentInsetOfTop - contentInsetOfBottom - lab_height - spacing
        
        let iv_y: CGFloat = contentInsetOfTop
        let iv_height: CGFloat = img_height
        let iv_width: CGFloat = iv_height
        let iv_x: CGFloat = 0.5 * (self.frame.size.width - iv_width)
        imgView.frame = CGRect.init(x: iv_x, y: iv_y, width: iv_width, height: iv_height)

        let tl_x: CGFloat = 0
        let tl_y: CGFloat = imgView.frame.maxY + spacing
        let tl_width: CGFloat = self.frame.size.width
        let tl_height: CGFloat = lab_height
        titleLab.frame = CGRect.init(x: tl_x, y: tl_y, width: tl_width, height: tl_height)
    }
    
    lazy var imgView: UIImageView = {
        let tempImgView = UIImageView()
        return tempImgView;
    }()
    lazy var titleLab: UILabel = {
        let tempTitleLab = UILabel()
        tempTitleLab.textAlignment = NSTextAlignment.center
        return tempTitleLab
    }()
}


extension String {
    ///
    /// Calculate the height of a string based on width and font size
    ///
    /// - parameter width: CGFloat
    /// - parameter font: UIFont
    ///
    /// - returns: The height of the calculated string
    ///
    fileprivate func calculateStringHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        let tempRect = (self as NSString).boundingRect(with: CGSize(width: width, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil)
        return tempRect.size.height
    }
}
