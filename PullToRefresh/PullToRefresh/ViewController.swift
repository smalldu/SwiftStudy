//
//  ViewController.swift
//  PullToRefresh
//
//  Created by duzhe on 15/9/22.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var timer:NSTimer!
    
    @IBOutlet weak var tb:UITableView!
    var dataArr = ["第一行","第二行","第三行","第四行","第五行"]
    var refreshControl: UIRefreshControl!
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tb.delegate = self
        tb.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.tintColor = UIColor.clearColor()
        tb.addSubview(refreshControl)
        
        loadCustomRefresh()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCustomRefresh(){
        let refresh = NSBundle.mainBundle().loadNibNamed("View", owner: self, options: nil)
        customView = refresh[0] as! UIView
        customView.frame = refreshControl.frame
        
        print( customView.subviews.count)

        for var i = 0 ; i < customView.subviews.count ; i++ {
           labelsArray.append(customView.viewWithTag(i+1) as! UILabel)
           self.labelsArray[i].alpha = 0
        }
        
        refreshControl.addSubview(customView)
    }
    
    func animateOne(){
        isAnimating = true
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
            
            }) { (finished) -> Void in
                
                UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformIdentity
                    self.labelsArray[self.currentLabelIndex].textColor = UIColor.whiteColor()
                    }, completion: { (finished) -> Void in
                        ++self.currentLabelIndex
                        
                        if self.currentLabelIndex < self.labelsArray.count {
                            self.animateOne()
                        }
                        else {
                            self.animateTwo()
                        }  
                })
                
        }
        
    }

    func animateTwo(){
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.labelsArray[0].transform = CGAffineTransformMakeScale(1.5, 1.5)
                self.labelsArray[1].transform = CGAffineTransformMakeScale(1.5, 1.5)
                self.labelsArray[2].transform = CGAffineTransformMakeScale(1.5, 1.5)
                self.labelsArray[3].transform = CGAffineTransformMakeScale(1.5, 1.5)
                self.labelsArray[4].transform = CGAffineTransformMakeScale(1.5, 1.5)
            
            }) { (finished) -> Void in
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    
                        self.labelsArray[0].transform = CGAffineTransformIdentity
                        self.labelsArray[1].transform = CGAffineTransformIdentity
                        self.labelsArray[2].transform = CGAffineTransformIdentity
                        self.labelsArray[3].transform = CGAffineTransformIdentity
                        self.labelsArray[4].transform = CGAffineTransformIdentity
//                        for lb in self.labelsArray{
//                            lb.transform = CGAffineTransformIdentity
//                        }
                    
                    }) { (finished) -> Void in
                        
                        if self.refreshControl.refreshing {
                            self.currentLabelIndex = 0
                            self.animateOne()
                        }
                        else {
                            self.isAnimating = false
                            self.currentLabelIndex = 0
                            for var i=0; i<self.labelsArray.count; ++i {
                                self.labelsArray[i].textColor = UIColor.whiteColor()
                                self.labelsArray[i].transform = CGAffineTransformIdentity
                            }
                        }
                }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        let sg = ( scrollView.contentOffset.y * -1 ) / 60.0
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            for var i=0; i<self.labelsArray.count; ++i {
                self.labelsArray[i].alpha = sg
                self.labelsArray[i].transform = CGAffineTransformMakeScale(sg>=1 ? 1:sg,sg)
            }
        }
    }
    
    //滚动结束的时候
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing {
            if !isAnimating {
                doSomething()
                animateOne()
            }
        }
    }
    func getNextColor() -> UIColor {
        var colorsArray: Array<UIColor> = [UIColor.magentaColor(), UIColor.brownColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor()]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        ++currentColorIndex
        
        return returnColor  
    }
    func doSomething() {
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "endOfWork", userInfo: nil, repeats: true)
    }
    
    func endOfWork() {
        refreshControl.endRefreshing()
        
        timer.invalidate()
        timer = nil
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = dataArr[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }

}

