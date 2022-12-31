//
//  SGBaseCollectionView.swift
//  SGBaseCollectionView
//
//  Created by kingsic on 2020/10/23.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

@objc public protocol SGBaseCollectionViewDataSource: NSObjectProtocol {
    /// Number of returned items
    func collectionView(_ baseCollectionView: SGBaseCollectionView, numberOfItems: Int) -> Int
    /// Data source
    func collectionView(_ baseCollectionView: SGBaseCollectionView, cell: UICollectionViewCell, cellForItemAt index: Int)
}

@objc public protocol SGBaseCollectionViewDelegate: NSObjectProtocol {
    /// Click event of item
    func collectionView(_ baseCollectionView: SGBaseCollectionView, didSelectItemAt index: Int)
}

public class SGBaseCollectionView: UIView {
    /// DataSource
    public var dataSource: SGBaseCollectionViewDataSource?
    
    /// Delegate
    public var delegate: SGBaseCollectionViewDelegate?
    
    /// Reload data
    public func reloadData() {
        collectionView.reloadData()
    }
    
    /// Item size. consider the top and bottom values of the contentinset property when setting the height
    public var itemSize: CGSize?
    
    /// Item minimumLineSpacing
    public var minimumLineSpacing: CGFloat? {
        willSet {
            if let tempNewValue = newValue {
                CVFLayout.minimumLineSpacing = tempNewValue < 0 ? 0 : tempNewValue
            }
        }
    }
    
    /// Item minimumInteritemSpacing
    public var minimumInteritemSpacing: CGFloat? {
        willSet {
            if let tempNewValue = newValue {
                CVFLayout.minimumInteritemSpacing = tempNewValue < 0 ? 0 : tempNewValue
            }
        }
    }
    
    /// Default UIEdgeInsetsZero. add additional scroll area around content
    public var contentInset: UIEdgeInsets? {
        willSet {
            if let tempNewValue = newValue {
                collectionView.contentInset = UIEdgeInsets.init(top: tempNewValue.top, left: tempNewValue.left, bottom: tempNewValue.bottom, right: tempNewValue.right)
            }
        }
    }
    
    fileprivate var tempIdentifier: String = "tempIdentifier"
    // For each reuse identifier that the collection view will use, register either a class or a nib from which to instantiate a cell.
    // If a nib is registered, it must contain exactly 1 top level object which is a UICollectionViewCell.
    // If a class is registered, it will be instantiated via alloc/initWithFrame:
    public func register(_ cellClass: UICollectionViewCell.Type, reuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier.isEmpty ? "cellID" : identifier)
        tempIdentifier = identifier.isEmpty ? "cellID" : identifier
    }
    
    public func register(_ nibName: String, reuseIdentifier identifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier.isEmpty ? "cellID" : identifier)
        tempIdentifier = identifier.isEmpty ? "cellID" : identifier
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
    public var showsHorizontalScrollIndicator: Bool? {
        willSet {
            if (newValue != nil) {
                collectionView.showsHorizontalScrollIndicator = newValue!
            }
        }
    }
    /// Default false. if true, show indicator while we are tracking. fades out after tracking
    public var showsVerticalScrollIndicator: Bool? {
        willSet {
            if (newValue != nil) {
                collectionView.showsVerticalScrollIndicator = newValue!
            }
        }
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
        return tempCVFLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let tempCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CVFLayout)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = self.backgroundColor
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.showsVerticalScrollIndicator = false
        return tempCollectionView
    }()
    
}

extension SGBaseCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.collectionView(self, numberOfItems: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tempIdentifier, for: indexPath)
        if dataSource != nil && (dataSource?.responds(to: #selector(dataSource?.collectionView(_:cell:cellForItemAt:)))) != nil {
            dataSource?.collectionView(self, cell: cell, cellForItemAt: indexPath.item)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil && ((delegate?.responds(to: #selector(delegate?.collectionView(_:didSelectItemAt:)))) != nil) {
            delegate?.collectionView(self, didSelectItemAt: indexPath.row)
        }
    }
}

