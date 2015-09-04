//
//  MyCollectionViewLayout.swift
//  UICollectionViewDemo
//
//  Created by duzhe on 15/9/4.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class MyCollectionViewLayout: UICollectionViewLayout {

    private var _cellCount:Int?
    private var _collectSize:CGSize?
    private var _center:CGPoint?
    private var _radius:CGFloat?
    private let ITEM_SIZE:CGFloat = 70.0
    private var insertIndexPaths = [NSIndexPath]()
    
    //一般在该方法中设定一些必要的layout的结构和初始需要的参数等
    override func prepareLayout() {
        super.prepareLayout()
        _collectSize = self.collectionView?.frame.size
        _cellCount = self.collectionView?.numberOfItemsInSection(0)
        _center = CGPointMake(_collectSize!.width / 2.0, _collectSize!.height / 2.0);
        _radius = min(_collectSize!.width, _collectSize!.height)/2.5
    }

    //内容区域的总大小 （不是可见区域）
    override func collectionViewContentSize() -> CGSize {
        return _collectSize!  //这里不用可见区域吧
    }
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
     
        var attributesArray = [UICollectionViewLayoutAttributes]()
        if let count = self._cellCount {
            for i in 0 ..< count{
                //这里利用了-layoutAttributesForItemAtIndexPath:来获取attributes
                let indexPath = NSIndexPath(forItem: i, inSection: 0)
                let attributes =  self.layoutAttributesForItemAtIndexPath(indexPath)
                attributesArray.append(attributes!)
            }
        }
        return attributesArray
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attrs.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE)
        let x = Double(_center!.x) + Double(_radius!) * cos(Double(2 * indexPath.item) * M_PI/Double(_cellCount!))
        let y = Double(_center!.y) + Double(_radius!) * sin(Double(2 * indexPath.item) * M_PI/Double(_cellCount!))
        attrs.center = CGPointMake( CGFloat(x) , CGFloat(y));
        return attrs
    }
    
    
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        // Must call super
        var attributes = super.initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath)
        
        if self.insertIndexPaths.contains(itemIndexPath) {
        
            if let _ = attributes{
                attributes = self.layoutAttributesForItemAtIndexPath(itemIndexPath)
            }
            
            // Configure attributes ...
            attributes!.alpha = 0.0;
            attributes!.center =  CGPointMake(_center!.x, _center!.y);
            attributes?.size = CGSizeMake(1000, 1000)
        }
        
        return attributes;
    }
    
    override func prepareForCollectionViewUpdates(updateItems: [UICollectionViewUpdateItem]) {
        super.prepareForCollectionViewUpdates(updateItems)
        self.insertIndexPaths = [NSIndexPath]()
        for update in updateItems{
            if update.updateAction == UICollectionUpdateAction.Insert{
                self.insertIndexPaths.append(update.indexPathAfterUpdate)
            }
        }
//        
//        for (UICollectionViewUpdateItem *update in updateItems)
//        {
//            if (update.updateAction == UICollectionUpdateActionDelete)
//            {
//                [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
//            }
//            else if (update.updateAction == UICollectionUpdateActionInsert)
//            {
//                [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
//            }
//        }
        
    }
    
}
