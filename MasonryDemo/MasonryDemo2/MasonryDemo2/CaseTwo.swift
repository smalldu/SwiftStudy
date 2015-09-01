//
//  CaseTwo.swift
//  MasonryDemo2
//
//  Created by duzhe on 15/9/2.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import SnapKit

class CaseTwo: UIViewController {

    
    let red = UIView()
    let blue = UIView()
    let green = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let btn = UIButton()
        btn.setTitle("返回", forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.purpleColor()
        btn.addTarget(self, action: "fun1", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        btn.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.left.equalTo(view.snp_left).offset(0)
            make.top.equalTo(view.snp_top).offset(25)
            make.width.equalTo(view.snp_width).multipliedBy(0.2)
            make.height.equalTo(40)
        }
        
        //case
//        let red = UIView()
        red.backgroundColor = UIColor.redColor()
        view.addSubview(red)
        
//        let blue = UIView()
        blue.backgroundColor = UIColor.blueColor()
        view.addSubview(blue)
        
//        let green = UIView()
        green.backgroundColor = UIColor.greenColor()
        view.addSubview(green)
        
        red.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.equalTo(view.snp_width).multipliedBy(0.2)
            make.height.equalTo(view.snp_height).multipliedBy(0.2)
            make.left.equalTo(view.snp_left).offset(20)
            make.bottom.equalTo(view.snp_bottom).offset(-20)
        }
        
        blue.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.height.equalTo(red)
            make.bottom.equalTo(red.snp_bottom)
            make.left.equalTo(red.snp_right).offset(20)
        }
        
        green.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.height.equalTo(blue)
            make.bottom.equalTo(blue.snp_bottom)
            make.left.equalTo(blue.snp_right).offset(20)
        }
        
        btn.setTitle("返回", forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.purpleColor()
        btn.addTarget(self, action: "fun1", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        let btn1 = UIButton()
        btn1.setTitle("动画", forState: UIControlState.Normal)
        btn1.backgroundColor = UIColor.purpleColor()
        btn1.addTarget(self, action: "fun2", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn1)

        btn1.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.right.equalTo(view.snp_right).offset(0)
            make.top.equalTo(view.snp_top).offset(25)
            make.width.equalTo(view.snp_width).multipliedBy(0.2)
            make.height.equalTo(40)
        }
        
    }
    
    func fun1(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("返回去")
        }
    }
    
    func fun2(){
        self.blue.removeFromSuperview()
        UIView.animateWithDuration(1, animations: {
                self.view.layoutIfNeeded()
        })
        
    }
    
}
