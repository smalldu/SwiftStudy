//
//  QuViewController.swift
//  StoneWeather
//
//  Created by duzhe on 15/9/5.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class QuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    private let Identity = "cell"
    private var info = [LocationInfo]()
    
    let tb = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "请选择区/县"
        self.view.backgroundColor = UIColor.whiteColor()
        tb.backgroundColor = UIColor.whiteColor()
        tb.frame = self.view.frame
        tb.backgroundColor = self.view.backgroundColor
        tb.delegate = self
        tb.dataSource = self
        self.view.addSubview(tb)
        tb.tableFooterView = UIView()  //空行不限是线条
        tb.registerClass(UITableViewCell.self, forCellReuseIdentifier: Identity)
        loadData()
    }
    
    func loadData(){
         let lc = CommonUtil.lcInfo
        for city in lc{
            if city.cityName == CommonUtil.currCity{
                info.append(city)
            }
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Identity, forIndexPath: indexPath)
        cell.textLabel?.text = info[indexPath.row].quName
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        CommonUtil.currArea = info[indexPath.row].localCode
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
