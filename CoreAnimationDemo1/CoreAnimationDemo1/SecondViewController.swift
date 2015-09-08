//
//  SecondViewController.swift
//  CoreAnimationDemo1
//
//  Created by duzhe on 15/9/6.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    let k=1056/10
    @IBOutlet var digitViews: [UIView]! //数组
    @IBOutlet weak var v1: UIView!
    let ly1 = CALayer()
    let ly2 = CALayer()
    let ly3 = CALayer()
    let ly4 = CALayer()
    let ly5 = CALayer()
    let ly6 = CALayer()
    var img:UIImage?
    @IBOutlet weak var v2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ly1.frame = CGRectMake(0, 0, 20, 20)
        ly1.backgroundColor = UIColor.redColor().CGColor
        v1.layer.addSublayer(ly1)
        
        
        ly2.frame = CGRectMake(40, 0, 20, 20)
        ly2.backgroundColor = UIColor.redColor().CGColor
        v1.layer.addSublayer(ly2)
        
        ly3.frame = CGRectMake(40,100, 50, 50)
        ly3.backgroundColor = UIColor.redColor().CGColor
        ly3.cornerRadius = 20 //设置圆角
        ly3.borderWidth = 5 //边框宽度
        ly3.borderColor = UIColor.blueColor().CGColor //边框颜色
        ly3.shadowOpacity = 0.5
        ly3.shadowOffset = CGSizeMake(2, 1)
        //ly3.shadowRadius = 15
        
        
        v1.layer.addSublayer(ly3)
        
        ly4.frame = CGRectMake(160,100, 50, 50)
        ly4.contents = UIImage(named: "n")?.CGImage
        ly4.shadowOpacity = 0.5  //这个阴影是针对内容的 而不是针对边框的
        v1.layer.addSublayer(ly4)
        //ly4.backgroundColor = UIColor.greenColor().CGColor
        v1.backgroundColor = UIColor.greenColor()
//      ly4.masksToBounds = true
        
        //ly4.cornerRadius = 20
        let squarePath = CGPathCreateMutable();
        CGPathAddRect(squarePath, nil, self.ly4.bounds); //方形的
//        CGPathAddEllipseInRect(squarePath, nil, self.ly4.bounds); //圆形的
        self.ly4.shadowPath = squarePath;
        //复杂一点的图形，UIBezierPath类
        
        loadAboutV2()
        
        
    }

    
    func loadAboutV2(){
        
        //图层蒙版 合成
        ly5.frame = CGRectMake(0,0, 50, 50)
        ly5.contents = UIImage(named: "n")?.CGImage
        
        ly6.frame = ly5.frame
        ly6.backgroundColor = UIColor.purpleColor().CGColor
        
        ly6.mask = ly5
        v2.layer.addSublayer(ly6)
        
        img = UIImage(named: "sz")!
        for item in digitViews{
            item.layer.contents = UIImage(named: "sz")!.CGImage
            item.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
            item.layer.contentsGravity = kCAGravityResizeAspect;
        }
        
        
       let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "showTime", userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func showTime(){
        
        let calendar = NSCalendar.currentCalendar()
//        let unitFlags =
        let comp = calendar.components(NSCalendarUnit.Second , fromDate: NSDate())

        setDigit(comp.second%10,ly: digitViews[0])
        setDigit(comp.second/10, ly: digitViews[1])
        
        let comp1 = calendar.components(NSCalendarUnit.Minute , fromDate: NSDate())
        setDigit(comp1.minute%10,ly: digitViews[2])
        setDigit(comp1.minute/10, ly: digitViews[3])
        
        let comp2 = calendar.components(NSCalendarUnit.Hour , fromDate: NSDate())
        setDigit(comp2.hour%10,ly: digitViews[4])
        setDigit(comp2.hour/10, ly: digitViews[5])
    }
    
    func setDigit(t:Int,ly:UIView){
       
        ly.layer.contentsRect = CGRectMake(0.1*CGFloat(t),0,0.1, 1);
       // ly.layer.contentsGravity = kCAGravityResizeAspectFill;
        //ly.frame = CGRectMake(5, 100, 10, <#T##height: CGFloat##CGFloat#>)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeIt(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var p = (touches as NSSet).anyObject()?.locationInView(v1);
        p = v1.layer.convertPoint(p!, fromLayer: v1.layer)
       
        //方法1
        if v1.layer.containsPoint(p!) {
            p = ly1.convertPoint(p!, fromLayer: v1.layer)
            if ly1.containsPoint(p!){
               let alert = UIAlertView(title: "点击了", message: "第一个被点击了", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
            p = ly2.convertPoint(p!, fromLayer: v1.layer)
            if ly2.containsPoint(p!){
                let alert = UIAlertView(title: "点击了", message: "第二个被点击了", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
        }
        
        //方法2
        let p1 = (touches as NSSet).anyObject()?.locationInView(self.v1);
        //p1 = v1.layer.convertPoint(p1!, fromLayer: v1.layer)
        let clickLayer = ly3.hitTest(p1!)
        print(ly3.frame)
        if(clickLayer == ly3){
            let alert = UIAlertView(title: "点击了", message: "第三个被点击了", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        let anoLayer = ly4.hitTest(p1!)
        if(anoLayer == ly4){
            let alert = UIAlertView(title: "点击了", message: "点击了小鸟", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }

}
