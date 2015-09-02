//
//  CaseThree.swift
//  MasonryDemo2
//
//  Created by duzhe on 15/9/2.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import SnapKit

class CaseThree: UIViewController {

    private let bgView = UIView()
    let lb1 = UILabel()
    let lb2 = UILabel()

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
        
        //case 并排两个label，宽度由内容决定。父级View宽度不够时，优先显示左边label的内容
        
        bgView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(bgView)
        
        bgView.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.width.equalTo(view.snp_width).multipliedBy(0.7)
            make.height.equalTo(40)
            make.left.equalTo(view.snp_left).offset(30)
            make.top.equalTo(btn.snp_bottom).offset(100)
        }
        
        let step = UIStepper()
        self.view.addSubview(step)
        step.addTarget(self, action: "stepClick:", forControlEvents: UIControlEvents.TouchUpInside);
        
        step.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.top.equalTo(bgView.snp_bottom).offset(30)
            make.left.equalTo(bgView.snp_left).offset(0)
        }
        
        let step1 = UIStepper()
        self.view.addSubview(step1)
        step1.addTarget(self, action: "stepClick1:", forControlEvents: UIControlEvents.TouchUpInside);
        
        step1.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.top.equalTo(bgView.snp_bottom).offset(30)
            make.left.equalTo(bgView.snp_right).offset(-80)
        }
        
        
        
//       let lb1 = UILabel()
        lb1.backgroundColor = UIColor.yellowColor()
        lb1.text = "测试Label"
        self.view.addSubview(lb1)
        
//        let lb2 = UILabel()
        lb2.backgroundColor = UIColor.blueColor()
        lb2.text = "测试Label2"
        self.view.addSubview(lb2)
        
        lb1.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            
            make.top.equalTo(bgView.snp_top).offset(2.5)
            make.left.equalTo(bgView.snp_left).offset(2)
            make.height.equalTo(35)
        }
       
        lb2.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            
            make.top.equalTo(bgView.snp_top).offset(2.5)
            make.left.equalTo(lb1.snp_right).offset(2)
            //右边的间隔保持大于等于2，注意是lessThanOrEqual
            make.right.lessThanOrEqualTo(bgView.snp_right).offset(-2)
            make.height.equalTo(35)
        }
        
        /*
        Content Compression Resistance = 不许挤我！
        
        对，这个属性说白了就是“不许挤我”=。=
        这个属性的优先级（Priority）越高，越不“容易”被压缩。也就是说，当整体的空间装不小所有的View的时候，Content Compression Resistance优先级越高的，现实的内容越完整。
        
        Content Hugging = 抱紧！
        
        这个属性的优先级越高，整个View就要越“抱紧”View里面的内容。也就是View的大小不会随着父级View的扩大而扩大。
        */
        
        print(UILayoutPriorityRequired) //1000
        //设置内容约束
        lb1.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        //250
        lb1.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        
        
        lb2.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        
        //1000
        lb2.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        
    }
    
    func fun1(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("返回去")
        }
    }
    
    func stepClick(step:UIStepper ){
//        print(step.value)
        var str = ""
        for i in 0...Int(step.value){
            if(i == 0){
                str = "测试Label"
            }else{
                str += ",测试！！"
            }
        }
        lb1.text = str
    }
    
    func stepClick1(step:UIStepper){
//        print(step.value)
        var str = ""
        for i in 0...Int(step.value){
            if(i == 0){
                str = "测试Label1"
            }else{
                str += ",测试！！"
            }
        }
        lb2.text = str
    }
    
    
    
}
