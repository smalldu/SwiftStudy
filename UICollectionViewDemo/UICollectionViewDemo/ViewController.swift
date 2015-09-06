//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by duzhe on 15/9/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

struct CellContent{
    var img:String
    var name:String
}

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var dic = Array<CellContent>()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical  //滚动方向
        layout.itemSize = CGSizeMake(60, 75) //设置所有cell的size  太重要了 找了半天。(自学就是辛苦呀！！)
        layout.minimumLineSpacing = 10.0  //上下间隔
        layout.minimumInteritemSpacing = 5.0 //左右间隔
        layout.headerReferenceSize = CGSizeMake(20, 20)
        layout.footerReferenceSize = CGSizeMake(20, 20)
        
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)  //缩进
        
        let collect:UICollectionView = UICollectionView(frame: self.view.frame,collectionViewLayout:layout)
        collect.backgroundColor = UIColor.whiteColor()
        collect.delegate = self
        collect.dataSource = self
        collect.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
//      collect.registerClass(MyCellContent.self, forCellWithReuseIdentifier: "DesignViewCell")
        
        let nib = UINib(nibName: "MyCollectionCell", bundle: NSBundle.mainBundle())
        collect.registerNib(nib, forCellWithReuseIdentifier: "DesignViewCell")
        for i in 1...9{
            dic.append(CellContent(img: "f"+String(i), name: "歪脖子"+String(i)))
        }
        
        self.view.addSubview(collect)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //设置分区个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //设置每个分区元素个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.dic.count
    }
    
    //设置元素内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let identify:String = "DesignViewCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identify, forIndexPath: indexPath) as! MyCellContent
        cell.contentView.backgroundColor = UIColor.grayColor()
        cell.contentView.alpha = 0.2
        let img = UIImage(named: (self.dic[indexPath.row] as CellContent).img)
        cell.contentImage.image = img
        cell.contentLabel.text = (self.dic[indexPath.row] as CellContent).name
    
        return cell
    }
    
    
    
    //点击元素
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
      print("点击了第\(indexPath.section) 分区 ,第\(indexPath.row) 个元素")
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
 
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
//这个自己设定每个cell大小
//    func collectionView(collectionView: UICollectionView!,
//        layout collectionViewLayout: UICollectionViewLayout!,
//        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
//     
//            return CGSizeMake(150, 150)
//    }

    
}

