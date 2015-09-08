//
//  ThirdViewController.swift
//  CoreAnimationDemo1
//
//  Created by duzhe on 15/9/7.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var btnOpca: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "变换页面"
        transV1()
        v2()
        v3()
    }

    func transV1(){
        //基础变换
        v1.layer.contents = UIImage(named: "xhh")?.CGImage
        let transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
//        v1.transform = transform
        v1.layer.setAffineTransform(transform)  //图层中二维变换
        v1.layer.shadowOpacity = 0.5
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var c_v2: UIView!
    @IBOutlet weak var c_v1: UIView!
    @IBOutlet weak var containView: UIView!
    
    
    func v2(){
        c_v1.layer.contents = UIImage(named: "xhh")?.CGImage
        c_v2.layer.contents = UIImage(named: "xhh")?.CGImage
        c_v2.layer.contentsGravity = kCAGravityResizeAspectFill
        c_v1.layer.contentsGravity = kCAGravityResizeAspectFill
        //Y轴变换
        
        var trans3d = CATransform3DIdentity
        trans3d.m34 = -1.0 / 500
        self.containView.layer.sublayerTransform = trans3d
        self.containView.backgroundColor = UIColor.grayColor()
        
        
        c_v1.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 1,1, 1)
        let transform = CATransform3DMakeRotation( CGFloat(M_PI), 0, 1, 0);
        c_v2.layer.transform = CATransform3DRotate(transform, CGFloat(M_PI_4), 0, -1, 0)
        
    }
    
    
    
    @IBAction func btnClick(sender: AnyObject) {
        
        //混合变换
//        var trans = CGAffineTransformIdentity;
//        trans = CGAffineTransformScale(trans, 0.5, 0.5);
//        trans = CGAffineTransformRotate(trans, CGFloat(M_PI/180.0 * 30.0))
//        trans = CGAffineTransformTranslate(trans, 200, 0)
//        self.v1.layer.setAffineTransform(trans)
        
        //3d变换
        var trans3d = CATransform3DIdentity;
        trans3d.m34 = -1.0 / 500.0
        trans3d = CATransform3DRotate(trans3d,CGFloat(M_PI_4), 0, 1, 0)
        
        v1.layer.transform = trans3d
    }
    
    @IBOutlet weak var conView: UIView!
    
    var mb=[UIView]()
    func v3(){
        mb =  NSBundle.mainBundle().loadNibNamed("square", owner: self, options: nil) as! [UIView];
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        self.conView.layer.transform = perspective
        
        for (k , _) in mb.enumerate() {
            var transform = CATransform3DMakeTranslation(100, 0, 0);
            if k == 2 {
                transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0, 1, 0);
            }else if k==3 {
                transform = CATransform3DMakeTranslation(0, -100, 0);
                transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 1, 0, 0);
            }else if k==4 {
                transform = CATransform3DMakeTranslation(0, 100, 0);
                transform = CATransform3DRotate(transform, CGFloat(-M_PI_2), 1, 0, 0);
            }else if k==5 {
                transform = CATransform3DMakeTranslation(-100, 0, 0);
                transform = CATransform3DRotate(transform, CGFloat(-M_PI_2), 0, 1, 0);
            }else if k==6 {
                transform = CATransform3DMakeTranslation(0, 0, -100);
                transform = CATransform3DRotate(transform, CGFloat(M_PI), 0, 1, 0);
            }
            addFace(k, withTransform: transform)
        }
        
        perspective = CATransform3DRotate(perspective, CGFloat(-M_PI_4), 1 , 0 , 0);
        perspective = CATransform3DRotate(perspective, CGFloat(-M_PI_4), 0 , 1 , 0);
        self.conView.layer.sublayerTransform = perspective
    }
    
    func addFace(index:Int , withTransform trans3d:CATransform3D){
        
        let face = mb[index]
        self.conView.addSubview(face)
        let containerSize = self.conView.bounds.size;
        face.center = CGPointMake(containerSize.width/2,containerSize.height/2)
        face.layer.transform = trans3d
    }

    @IBAction func hidePage(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
