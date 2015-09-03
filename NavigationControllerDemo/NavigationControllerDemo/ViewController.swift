//
//  ViewController.swift
//  NavigationControllerDemo
//
//  Created by duzhe on 15/9/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "goNext:")
        self.title = "导航标题"  //设置导航栏title（不是  self.navigationController?.title 哦！）
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "我把返回修改了", style: .Plain, target: nil, action: nil)
        
        //UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func goNext(sender:AnyObject){
        print("去下一个咯")
        let mainVc = UIStoryboard(name: "Third", bundle: nil).instantiateViewControllerWithIdentifier("three") as UIViewController
        self.navigationController?.pushViewController(mainVc, animated: true)
    }
    
    
}

