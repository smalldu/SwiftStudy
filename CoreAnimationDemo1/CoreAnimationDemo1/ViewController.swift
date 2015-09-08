//
//  ViewController.swift
//  CoreAnimationDemo1
//
//  Created by duzhe on 15/9/6.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v1: UIView!
    let ly1 = CALayer()
    
    @IBOutlet weak var v3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        v1.backgroundColor = UIColor.redColor()
        v1.layer.contents = UIImage(named: "xhh")?.CGImage
        v1.layer.contentsGravity = kCAGravityResizeAspectFill
        v1.layer.cornerRadius = 40
        v1.layer.masksToBounds = true
        //v1.layer.contentsCenter = CGRectMake(0, 0, 1, 0.2) 没太搞懂
        //v1.layer.contentsRect = CGRectMake(0.5,0.5,0.5, 0.5);   //剪裁
        
        let ly1 = CALayer()
        ly1.frame = CGRectMake(0,0,100, 100)
        ly1.backgroundColor = UIColor.blueColor().CGColor
        
        ly1.delegate = self //设置代理
        v2.layer.addSublayer(ly1)
        ly1.contentsScale = UIScreen.mainScreen().scale
        
        ly1.display() //强制重新绘制  会调用下面的方法
        
        drawV3()
    }
    
    func drawV3(){
        let ly2 = CALayer()
        ly2.backgroundColor = UIColor.yellowColor().CGColor
        ly2.frame = CGRectMake(0, 0, 100, 100)
        ly2.anchorPoint = CGPointMake(0,0)
        
        print(ly2.position)
        v3.layer.addSublayer(ly2)
    }
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        
        print("强制绘制")
        CGContextSetLineWidth(ctx, 10)
        CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextStrokeEllipseInRect( ctx , layer.bounds)
        
    }
    var flag = true
    @IBAction func scaleV1(sender: UIButton) {
        //UIView的一些动画操作
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("fun")  //动画完成后回调
        if flag {
            v1.transform = CGAffineTransformMakeScale(0.5, 0.5)
            flag = false
        }else {
            v1.transform = CGAffineTransformMakeScale(1,1)
            flag = true
        }
        UIView.commitAnimations()
        
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.v2.transform = CGAffineTransformMakeRotation(90)
            self.v3.transform = CGAffineTransformMakeTranslation(0, -100)
        }
        
    }
    
    func fun(){
        print("动画执行完了")
    }
    
}

