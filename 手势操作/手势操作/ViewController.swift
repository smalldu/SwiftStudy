//
//  ViewController.swift
//  手势操作
//
//  Created by duzhe on 15/9/9.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:"); //点击手势
//        tap.numberOfTapsRequired = 2  //双击事件    默认点一下
        self.view.addGestureRecognizer(tap)  //添加手势
        
        
        let pinch = UIPinchGestureRecognizer(target: self, action: "handlePinch:");
        self.view.addGestureRecognizer(pinch)
        
        //旋转手势
        let rotation = UIRotationGestureRecognizer(target: self, action: "handleRotation:")
        self.view.addGestureRecognizer(rotation)
        
        //拖动手势
        let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
        self.view.addGestureRecognizer(pan)
        
        //滑动手势
        let swipRight = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        swipRight.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipRight)
        
        //长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action:"longPress")
        longPress.minimumPressDuration = 1
        longPress.allowableMovement = 10
        longPress.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(longPress)
        
    }
    
    func handleTap(sender :UITapGestureRecognizer){
        print(sender.locationInView(self.view)) //点击的位置
    }
    
    
    func handlePinch(sender:UIPinchGestureRecognizer){
        let scale = sender.scale
        print("捏合\(scale)")
        
        //判断状态是否结束
        if sender.state == UIGestureRecognizerState.Ended{
            print("over")
        }
    }
    
    func handleRotation(sender:UIRotationGestureRecognizer){
        let rotate = sender.rotation
        
        print("rotation\(rotate)")
        
    }

    
    func handlePan(sender:UIPanGestureRecognizer){
        let p = sender.translationInView(view)
        
        print("拖动\(p)")
    }
    
    
    func swipeRight(sender:UISwipeGestureRecognizer){
        
        let direction = sender.direction
        switch direction {
        case UISwipeGestureRecognizerDirection.Left:
            print("left")
            break;
        case UISwipeGestureRecognizerDirection.Right:
            print("right")
            break
        case UISwipeGestureRecognizerDirection.Up:
            print("Up")
            break
        case UISwipeGestureRecognizerDirection.Down:
            print("Down")
            break
        default:
            break
        }
        
    }
    
    func longPress(sender:UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizerState.Began {
            UIAlertAction(title: "nihao", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                print(action)
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

