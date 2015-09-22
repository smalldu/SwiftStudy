//
//  ViewController.swift
//  AnimationDemo3
//
//  Created by duzhe on 15/9/8.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segment1: UISegmentedControl!
    
    @IBOutlet weak var v1: UIView!
    let view1:UIView = UIView()
    let view2:UIView = UIView()
    
    @IBOutlet weak var Kview: UIView!
    
    let ly1 = CALayer()
    let ly2 = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.title = "隐式动画"
        
        view2.frame = self.view.bounds
        view1.frame = self.view.bounds
        view1.backgroundColor = UIColor.redColor()
        view2.backgroundColor = UIColor.yellowColor()
        
        self.view.addSubview(view1)
        //self.view.insertSubview(v1, aboveSubview:view2)
        
        ly1.frame = CGRectMake( 90,50 , 100, 100)
        ly1.backgroundColor = UIColor.blueColor().CGColor
        v1.layer.addSublayer(ly1)
//        print(v1.frame)
//        print(v2.frame)
        
        
        
        ly2.frame = CGRectMake( 90,50 , 100, 100)
        ly2.backgroundColor = UIColor.blueColor().CGColor
         Kview.layer.addSublayer(ly2)
        
        let transition = CATransition()  //动画行为
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        ly1.actions = ["backgroundColor" : transition]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func change(sender: AnyObject) {
        
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(1)
//        CATransaction.setCompletionBlock {
//            var trans = self.ly1.affineTransform()
//            trans = CGAffineTransformRotate(trans, CGFloat(M_PI_2))
//            self.ly1.setAffineTransform(trans)
//        }
//      
//        let red = CGFloat(arc4random_uniform(18736)) / CGFloat(18736.0)
//        let green = CGFloat(arc4random_uniform(18736)) / CGFloat(18736.0)
//        let blue = CGFloat(arc4random_uniform(18736)) / CGFloat(18736.0)
//        ly1.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1).CGColor
//        CATransaction.commit()
//        UIView.animateWithDuration(0.3) { () -> Void in
//            
//            self.view2.transform = CGAffineTransformMakeTranslation(100, 0)
//            
//        }
        let red = CGFloat(arc4random_uniform(18736)) / CGFloat(18736.0)
        let green = CGFloat(arc4random_uniform(18736)) / CGFloat(18736.0)
        let blue = CGFloat(arc4random_uniform(18736)) / CGFloat(18736.0)
        let cc = UIColor(red: red, green: green, blue: blue, alpha: 1).CGColor
        let ani = CABasicAnimation()
        //ani.keyPath = "backgroundColor"
        ani.keyPath = "transform.rotation"  //虚拟属性  实际没有这个属性
//        ani.toValue = cc
        ani.byValue = CGFloat(M_PI)
        ani.duration = 1
        ani.delegate = self
        ani.setValue(ly1, forKey: "ly1")
        ly1.addAnimation(ani, forKey: nil)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        if let aniB = anim as? CABasicAnimation
        {
            print(aniB.valueForKey("ly1") as! CALayer == ly1)  //true  哈哈，这样就可以成功的识别是哪个view的动画了！

            //ly1.backgroundColor = (aniB.toValue as! CGColorRef)
        }
        CATransaction.commit()
    }
  
    
    //处理关键帧动画
    @IBAction func kFrameAni(sender: AnyObject) {
        
        let kf = CAKeyframeAnimation()
        kf.keyPath = "backgroundColor"
        kf.duration = 2.0
        kf.values = [
                        UIColor.blackColor().CGColor,
                        UIColor.redColor().CGColor,
                        UIColor.whiteColor().CGColor,
                        UIColor.greenColor().CGColor
                    ]
//        kf.path =  可以设置一个贝塞尔曲线
//        kf.rotationMode = kCAAnimationRotateAuto;
        
    
        
        ly2.addAnimation(kf, forKey: nil)
        
    }
}

