//
//  SGCycleScrollView.swift
//  Flower
//
//  Created by kingsic on 2022/7/30.
//
//  Warning：SGCycleScrollView 的高度必须为整数，否则会导致滚动错乱
//

import UIKit

@objc public protocol SGCycleScrollViewDelegate: NSObjectProtocol {
    /// Item 的点击事件
    @objc optional func cycleScrollView(_ cycleScrollView: SGCycleScrollView, didSelectItemAt index: Int)
    
    /// Item 的滚动事件
    @objc optional func cycleScrollView(_ cycleScrollView: SGCycleScrollView, didEndScrollingToItemAt index: Int)
}

@objc public protocol SGCycleScrollViewDataSource: NSObjectProtocol {
    /// Item 的个数
    @objc optional func numberOfItems(_ cycleScrollView: SGCycleScrollView) -> Int
    
    /// Cell
    @objc optional func cycleScrollView(_ cycleScrollView: SGCycleScrollView, cell: UICollectionViewCell, cellForItemAt index: Int)
}

@objc public class SGCycleScrollView: UIView {

    /// Delegate
    @objc public weak var delegate: SGCycleScrollViewDelegate?
    
    /// DataSource
    @objc public weak var dataSource: SGCycleScrollViewDataSource?

    /// 是否无限循环，默认为：true
    @objc public var infiniteLoop: Bool = true
    
    /// 滚动所需时间，默认为：0.0
    @objc public var timeInterval: TimeInterval = 0.0 {
        didSet {
            if timeInterval > 0 {
                DispatchQueue.main.async { [self] in
                    addTimer()
                }
            }
        }
    }
    
    /// 是否自动滚动，默认为：true
    @objc public var autoScroll: Bool = true {
        didSet {
            if autoScroll == false {
                removeTimer()
            }
        }
    }
    
    /// 是否支持手势拖拽，默认为：true
    @objc public var isScrollEnabled: Bool = true {
        didSet {
            if isScrollEnabled == false {
                collectionView.isScrollEnabled = false
            }
        }
    }
    
    
    /// 是否需要反弹效果，默认为：true
    @objc public var bounces: Bool = true {
        didSet {
            if bounces == false {
                collectionView.bounces = false
            }
        }
    }
    
    /// 滚动方向
    @objc public var scrollDirection: UICollectionView.ScrollDirection = .horizontal {
        willSet {
            flowLayout.scrollDirection = newValue
        }
    }
    

    fileprivate var tempIdentifier: String = "tempIdentifier"

    /// 纯代码注册 Cell
    @objc public func register(_ cellClass: UICollectionViewCell.Type, reuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier.isEmpty ? "cellID" : identifier)
        tempIdentifier = identifier.isEmpty ? "cellID" : identifier
    }
    
    /// 使用 Nib 注册 Cell
    @objc public func registerNib(_ name: String, reuseIdentifier identifier: String) {
        let nib = UINib(nibName: name, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier.isEmpty ? "cellID" : identifier)
        tempIdentifier = identifier.isEmpty ? "cellID" : identifier
    }
    
    /// 刷新数据
    @objc public func reloadData() {
        collectionView.reloadData()
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubview(collectionView)
    }
    
    var numberOfItems: Int = 0
    
    var timer: Timer?
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = scrollDirection
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        flowLayout.itemSize = bounds.size
        collectionView.frame = bounds
        
        collectionView.scrollToItem(at: IndexPath.init(item: 0, section: infiniteLoop == true ? 25 : 0), at: .bottom, animated: false)
    }
}

extension SGCycleScrollView {
    func addTimer() {
        
        guard autoScroll == true else {
            return
        }
        
        guard infiniteLoop == true else {
            return
        }
        
        removeTimer()
        
        timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateUI() {
        let currentIndexPath = collectionView.indexPathsForVisibleItems.last
        
        let indexPath = NSIndexPath(item: currentIndexPath!.item, section: infiniteLoop == true ? 25 : 0)
        
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: false)
        
        var nextItem = indexPath.item + 1
        var nextSection = indexPath.section
        
        if nextItem == numberOfItems {
            nextItem = 0
            nextSection+=1
        }
        
        let nextIndexPath = IndexPath.init(item: nextItem, section: nextSection)
        
        collectionView.scrollToItem(at: nextIndexPath, at: .bottom, animated: true)
    }
}

extension SGCycleScrollView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard delegate != nil else {
            return
        }
        
        if (delegate!.responds(to: #selector(delegate!.cycleScrollView(_:didSelectItemAt:)))) {
            delegate!.cycleScrollView!(self, didSelectItemAt: indexPath.item)
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScroll && timeInterval > 0 {
            removeTimer()
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if autoScroll && timeInterval > 0 {
            addTimer()
        }
        
        scrollViewDidEndScrollingAnimation(collectionView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard delegate != nil else {
            return
        }
        
        let p = self.convert(collectionView.center, to: collectionView)
        let indexPath = collectionView.indexPathForItem(at: p)
        
        if delegate!.responds(to: #selector(delegate!.cycleScrollView(_:didEndScrollingToItemAt:))) {
            delegate!.cycleScrollView!(self, didEndScrollingToItemAt: indexPath!.item)
        }
    }
}


extension SGCycleScrollView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        infiniteLoop == true ? 50 : 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tempDataSource = dataSource else {
            return 1
        }
        numberOfItems = (tempDataSource.numberOfItems?(self))!
        return numberOfItems
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tempIdentifier, for: indexPath)
    
        guard let tempDataSource = dataSource else {
            return cell
        }
        
        if tempDataSource.responds(to: #selector(dataSource?.cycleScrollView(_:cell:cellForItemAt:))) {
            dataSource?.cycleScrollView?(self, cell: cell, cellForItemAt: indexPath.row)
        }
        return cell
    }

}
