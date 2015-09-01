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

        //case
        
        
        
      
    }
    
    func fun1(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("返回去")
        }
    }
}
