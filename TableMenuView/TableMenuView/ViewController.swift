//
//  ViewController.swift
//  TableMenuView
//
//  Created by duzhe on 15/9/5.
//  Copyright (c) 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MenuViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabMenu = TableMenuView .new()
        tabMenu.delegate = self
        self.view.addSubview(tabMenu)
        tabMenu.setSelectIndexForClass1(class1: 0,class2: -1)
        tabMenu.showAsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func assciationMenuView(asView: TableMenuView, countForClass idx: Int) -> Int {
        
        return 10
    }
    
    func assciationMenuView(asView: TableMenuView, titleForClass_1 idx_1: Int) -> String {
        
        return "thisss"
    }
}

