//
//  UserDefineViewController.swift
//  UICollectionViewDemo
//
//  Created by duzhe on 15/9/4.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class UserDefineViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate  {

    var dic = Array<CellContent>()
    var collect:UICollectionView!
    var layout:UICollectionViewLayout = MyCollectionViewLayout()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.yellowColor()
        
        layout = MyCollectionViewLayout()
        
        collect = UICollectionView(frame: self.view.frame,collectionViewLayout:layout)
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
        
        
        //注册tap手势事件
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        collect.addGestureRecognizer(tapRecognizer)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "切换布局", style: .Plain, target: self, action: "changeLayout")
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
        //        cell.backgroundView
        //        cell.selectedBackgroundView?.backgroundColor = UIColor.grayColor()
        //        cell.selected = true
        cell.contentView.backgroundColor = UIColor.grayColor()
        cell.contentView.alpha = 0.2
        let img = UIImage(named: (self.dic[indexPath.row] as CellContent).img)
        cell.contentImage.image = img
        cell.contentLabel.text = (self.dic[indexPath.row] as CellContent).name
        cell.layer.cornerRadius = 35
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.blackColor().CGColor
        return cell
    }
    


    func handleTap(sender:UITapGestureRecognizer){
        if sender.state == UIGestureRecognizerState.Ended{
            let tapPoint = sender.locationInView(self.collect)
            if let  indexPath = self.collect.indexPathForItemAtPoint(tapPoint)
            {
                //点击了cell
                //这个方法可以用来对collectionView中的元素进行批量的插入，删除，移动等操作，同时将触发collectionView所对应的layout的对应的动画。
                print("------")
                self.collect.performBatchUpdates({ () -> Void in
                    self.collect.deleteItemsAtIndexPaths([indexPath])
                    self.dic.removeAtIndex(indexPath.row)
                }, completion: nil)
                
            }else{
                
               
                let val =  arc4random_uniform(8)+1
                self.dic.append(CellContent(img: "f"+String(val), name: "歪脖子"+String(val)))

                self.collect.insertItemsAtIndexPaths([NSIndexPath(forItem: Int(val) , inSection: 0)])
//                dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
//                     let val =  arc4random_uniform(9)
//                    self.dic.append(CellContent(img: "f"+String(val), name: "歪脖子"+String(val)))
//                    dispatch_async(dispatch_get_main_queue()) {
//                            self.collect.reloadData()
//                    
//                    }
//                })
                //点击了不是cell的区域
                print("+++++++")
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //切换布局 （可以自定义几套去切换哦）
     func changeLayout() {
        if(layout is MyCollectionViewLayout){
            layout = UICollectionViewFlowLayout()
            (layout as! UICollectionViewFlowLayout).scrollDirection = UICollectionViewScrollDirection.Vertical  //滚动方向
            (layout as! UICollectionViewFlowLayout).itemSize = CGSizeMake(60, 75)
        }else{
            layout = MyCollectionViewLayout()
        }
        self.collect.setCollectionViewLayout(layout, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
