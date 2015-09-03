//
//  ViewControllerTwo.swift
//  NavigationControllerDemo
//
//  Created by duzhe on 15/9/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

protocol ParameterDelegate{
    func passParams(tmpStr: String)
}

class ViewControllerTwo: UIViewController,ParameterDelegate {

    
    @IBOutlet weak var tf1: UITextField!
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //第一种传值方式 , 利用公开方法 传值
    @IBAction func method1(sender: UIButton) {
        let vc = ViewControllerFour()
        vc.delegate = self  //通过代理进行反向传值
        let value = tf1.text
        vc.passParams(value!)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func method2(sender: AnyObject) {
        //这个方法没有好像值穿不过去。不知道为啥。放着什么都不写就可以
    }
    //通过segue进行的传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "m2" {
//            let vc = segue.destinationViewController as! ViewControllerFour
//            vc.tmpStr = tf1.text
//        }
        
        if segue.identifier == "toshow" {
            let vc = segue.destinationViewController as! ViewControllerTwoShow
            vc.tmpStr = tf1.text
            //vc.setValue(tf1, forKey: "tmpStr")
        }
    }
    //使用通知 。。不推荐
    @IBAction func method3(sender: UIButton) {
        //发布一条通知
        
        let vc = ViewControllerFour()
        vc.delegate = self  //通过代理进行反向传值
        
        self.presentViewController(vc, animated: true) { () -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("DefaultNotif", object:self.tf1.text)
        }
        //self.navigationController?.pushViewController(vc, animated: true)
       
    }
    @IBAction func goNext(sender: UIBarButtonItem) {
        
        let vc = ViewControllerFour()
         vc.delegate = self 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("返回")
        }
    }
    
    func passParams(tmpStr: String){
        tf1.text = tmpStr
    }
    
}
