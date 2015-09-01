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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

