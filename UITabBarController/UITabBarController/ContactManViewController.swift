//
//  ContactManViewController.swift
//  UITabBarController
//
//  Created by duzhe on 15/9/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ContactManViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.title = "聊 天"
        
        self.tabBarItem.title = "Contact"
        let img = UIImage(named: "contact")
        let scaledImage = img!.scaleImage(img!, scaleSize: CGFloat(0.05))
        self.tabBarItem.image = scaledImage
        
        self.tabBarItem.badgeValue = "1"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
