//
//  AppDelegate.swift
//  UITabBarController
//
//  Created by duzhe on 15/9/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        let tabController = UITabBarController();
        
        let webChat = WebChatViewController()
        let contact = ContactManViewController()
        
        tabController.viewControllers = [webChat,contact]
        //注意默认情况下UITabBarController在加载子视图时是懒加载的，所以这里调用一次contactController，否则在第一次展示时只有第一个控制器tab图标，contactController的tab图标不会显示
        
        print(tabController.viewControllers?.enumerate() )
//可选类型会报错
//        for (k,v) in tabController.viewControllers?.enumerate(){
//            print(k)
//        }
        
        if let cvs = tabController.viewControllers {
            for cv in cvs {
                let view = cv.view
            }
        }
        
        
        window?.rootViewController = tabController
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

