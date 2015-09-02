//
//  ViewController.swift
//  MasonryDemo2
//
//  Created by duzhe on 15/9/1.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = true;
        view1.backgroundColor = UIColor.redColor()
        self.view.addSubview(view1)
        self.view.sendSubviewToBack(view1)
        let padding = UIEdgeInsetsMake(10, 10, 10, 10);
        
        view1.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.edges.equalTo(self.view).inset(padding)
        }
        
        let greyView = UIView()
        greyView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(greyView)
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(blueView)
        
        let yellow = UIView()
        yellow.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(yellow)
        
        let green = UIView()
        green.backgroundColor = UIColor.greenColor()
        self.view.addSubview(green)
        
        //设置了greyView得约束
        greyView.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.left.equalTo(view1.snp_left).offset(0) //使左边等于view1的左边
            make.top.equalTo(view1.snp_top).offset(0) //使顶部等于view1的顶部
            make.width.equalTo(view1.snp_width).multipliedBy(0.5) //multipliedBy是倍数的意思 宽度为view1的一半
            make.height.equalTo(view1.snp_height).multipliedBy(0.5) //高度为view1的一半
        }
        
        //设置了blueView得约束
        blueView.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.height.equalTo(greyView)  //使之与blueView等宽等高
            make.top.equalTo(greyView.snp_top)
            make.left.equalTo(greyView.snp_right).offset(0)           //与blueView无间距
        }
        
        yellow.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.height.equalTo(greyView)  //使之与yellow等宽等高
            make.top.equalTo(greyView.snp_bottom).offset(0)
            make.left.equalTo(view1.snp_left).offset(0)           //与yellow无间距
        }
        
        green.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.height.equalTo(greyView)  //使之与green等宽等高
            make.top.equalTo(yellow.snp_top)
            make.left.equalTo(yellow.snp_right).offset(0)           //与green无间距
        }
        
        let btn = UIButton()
        btn.setTitle("案例 1", forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.purpleColor()
        btn.addTarget(self, action: "fun1", forControlEvents: UIControlEvents.TouchUpInside)
        //view.insertSubview(btn, aboveSubview: greyView)
        self.view.insertSubview(btn, atIndex: 10)
        btn.alpha = 0.7
        
        btn.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.left.equalTo(view1.snp_left).offset(0)
            make.top.equalTo(view1.snp_top).offset(5)
            make.width.equalTo(view1.snp_width)
            make.height.equalTo(40)
        }
        
        
        let btn1 = UIButton()
        btn1.setTitle("案例 2", forState: UIControlState.Normal)
        btn1.backgroundColor = UIColor.purpleColor()
        btn1.addTarget(self, action: "fun2", forControlEvents: UIControlEvents.TouchUpInside)
        //view.insertSubview(btn, aboveSubview: greyView)
        self.view.insertSubview(btn1, atIndex: 10)
        btn1.alpha = 0.7
        
        btn1.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.left.equalTo(view1.snp_left).offset(0)
            make.top.equalTo(btn.snp_bottom).offset(5)
            make.width.equalTo(view1.snp_width)
            make.height.equalTo(40)
        }

        
        let btn2 = UIButton()
        btn2.setTitle("案例 3", forState: UIControlState.Normal)
        btn2.backgroundColor = UIColor.purpleColor()
        btn2.addTarget(self, action: "fun3", forControlEvents: UIControlEvents.TouchUpInside)
        //view.insertSubview(btn, aboveSubview: greyView)
        self.view.insertSubview(btn2, atIndex: 10)
        btn2.alpha = 0.7
        
        btn2.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.left.equalTo(view1.snp_left).offset(0)
            make.top.equalTo(btn1.snp_bottom).offset(5)
            make.width.equalTo(view1.snp_width)
            make.height.equalTo(40)
        }

    }
    
    func fun1(){
       let c1 =  CaseOne()
       self.presentViewController(c1, animated: true) { () -> Void in
            print("into case 1")
        }
    }
    func fun2(){
        let c2 =  CaseTwo()
        self.presentViewController(c2, animated: true) { () -> Void in
            print("into case 2")
        }
    }
    
    func fun3(){
        let c3 =  CaseThree()
        self.presentViewController(c3, animated: true) { () -> Void in
            print("into case 3")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

