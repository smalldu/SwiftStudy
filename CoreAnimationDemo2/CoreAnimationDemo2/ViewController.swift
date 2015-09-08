//
//  ViewController.swift
//  CoreAnimationDemo2
//
//  Created by duzhe on 15/9/7.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtView: UIView!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let beziierPath = UIBezierPath()
        beziierPath.moveToPoint(CGPointMake(100, 100));
        beziierPath.addArcWithCenter(CGPointMake(75, 100), radius: 25, startAngle:0, endAngle:CGFloat(2*M_PI), clockwise: true)
        beziierPath.moveToPoint(CGPointMake(75, 125))
        beziierPath.addLineToPoint(CGPointMake(75, 175))
        beziierPath.moveToPoint(CGPointMake(50, 150))
        beziierPath.addLineToPoint(CGPointMake(100, 150))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineWidth = 5
        shapeLayer.path = beziierPath.CGPath
        
        self.contentView.layer.addSublayer(shapeLayer)
        
        let rect = CGRectMake(100,120 , 100, 100);
        let size = CGSizeMake(20, 20)
        let corner = UIRectCorner.TopLeft.rawValue | UIRectCorner.TopRight.rawValue | UIRectCorner.BottomLeft.rawValue
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner(rawValue: corner), cornerRadii: size)
        
        
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.strokeColor = UIColor.redColor().CGColor
        shapeLayer1.fillColor = UIColor.clearColor().CGColor
//        
//        shapeLayer1.lineCap = kCALineCapRound
//        shapeLayer1.lineJoin = kCALineJoinRound
        shapeLayer1.lineWidth = 5
        shapeLayer1.path = path.CGPath
        
        self.contentView.layer.addSublayer(shapeLayer1)
        
        initTxt();
        
    }

    func initTxt(){
        
        let txtLayer = CATextLayer();
        txtLayer.frame = CGRectMake(0,0, 200, 100)
        txtLayer.backgroundColor = UIColor.blackColor().CGColor
        txtLayer.alignmentMode = kCAAlignmentJustified
        txtLayer.wrapped = true
        
        let font = UIFont.systemFontOfSize(15)
        let fontRef = CGFontCreateWithFontName(font.fontName)
        
        txtLayer.font = fontRef
        txtLayer.fontSize = font.pointSize
        let str = "这是一个美好的早上 ， let us do some useful things , such as coding ."
        txtLayer.string = str
        
        txtView.layer.addSublayer(txtLayer)
        
        //去像素化
        txtLayer.contentsScale = UIScreen.mainScreen().scale
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

