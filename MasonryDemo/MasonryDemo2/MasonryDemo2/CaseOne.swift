//
//  CaseOne.swift
//  MasonryDemo2
//
//  Created by duzhe on 15/9/2.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import SnapKit

class CaseOne: UIViewController {

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
        
        let lb = UILabel()
        lb.text = "可以试试切换横竖屏哦！"
        self.view.addSubview(lb)
        lb.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.left.equalTo(view.snp_left).offset(20)
            make.top.equalTo(btn.snp_top).offset(50)
        }
        
        
        //case
        let grey1 = UIView()
        grey1.backgroundColor = UIColor.grayColor()
        self.view.addSubview(grey1)
        
        let grey2 = UIView()
        grey2.backgroundColor = UIColor.grayColor()
        self.view.addSubview(grey2)
        
        let grey3 = UIView()
        grey3.backgroundColor = UIColor.grayColor()
        self.view.addSubview(grey3)
      
        let red1 = UIView()
        red1.backgroundColor = UIColor.redColor()
        self.view.insertSubview(red1, aboveSubview: grey1)
        
        let red2 = UIView()
        red2.backgroundColor = UIColor.redColor()
        self.view.insertSubview(red2, aboveSubview: grey1)

        grey1.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-50)
            //make.width.equalTo(view.snp_width)
            make.height.equalTo(20)
            make.left.equalTo(view.snp_left).offset(0)
            
        }
        
        red1.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            
            make.width.equalTo(100);
            make.height.equalTo(50);
            make.bottom.equalTo(grey1.snp_bottom)
            make.left.equalTo(grey1.snp_right)
        }
        
        grey2.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.height.equalTo(grey1)
            make.bottom.equalTo(grey1.snp_bottom)
            make.left.equalTo(red1.snp_right)
            
        }
        
        red2.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.height.equalTo(red1)
            make.bottom.equalTo(grey1.snp_bottom)
            make.left.equalTo(grey2.snp_right)
        }

        grey3.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.height.equalTo(grey1)
            make.bottom.equalTo(grey1.snp_bottom)
            make.left.equalTo(red2.snp_right)
            make.right.equalTo(view.snp_right).offset(0)
        }
        
    }
    
    func fun1(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("返回去")
        }
    }
}
