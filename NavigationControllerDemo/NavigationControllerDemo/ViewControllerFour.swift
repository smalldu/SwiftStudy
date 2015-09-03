//
//  ViewControllerFour.swift
//  NavigationControllerDemo
//
//  Created by duzhe on 15/9/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewControllerFour: UIViewController {

    
    var delegate:ParameterDelegate?
    var tmpStr:String?
    private var lb = UILabel()
    private var lb1 = UILabel()
    private var lb2 = UILabel()
    private var tf = UITextField()
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.setNavigationBarHidden(true, animated: true) //隐藏导航栏
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "doSomeT:", name: "DefaultNotif", object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        
        let btn = UIButton()
        btn.frame = CGRectMake(100, 100, 100, 50);
        btn.setTitle("返回", forState: .Normal)
        btn.addTarget(self, action: "fun", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)

        
        lb.frame = CGRectMake(50, 200, 200, 50);
        lb.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(lb);
        
        lb1.frame = CGRectMake(50, 300, 200, 50);
        lb1.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(lb1);
        lb1.text = tmpStr
        
        
        lb2.frame = CGRectMake(50, 400, 200, 50);
        lb2.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(lb2);
        
        tf.frame = CGRectMake(0, 0, 200, 50);
        tf.placeholder = "请出入传回去的值"
        tf.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(tf);
        
    }
    

    func fun(){
    
        delegate?.passParams(tf.text!)
        self.navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("通知的方式用这个返回")
        }
        
//        self.navigationController?.popViewControllerAnimated(true)
//        self.navigationController?.popToViewController(someCv, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func  passParams(tmpStr: String){
        lb.text = tmpStr
    }
    
    func doSomeT(title:NSNotification){
        print("哈哈哈")
        lb1.text = title.object as? String
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
