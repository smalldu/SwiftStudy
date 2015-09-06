//
//  CitysViewController.swift
//  StoneWeather
//
//  Created by duzhe on 15/9/5.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class CitysViewController:  UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    private let Identity = "cell"
    let tb = UITableView()
    var privince = ""
    var citys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "请选择城市"
        self.view.backgroundColor = UIColor.whiteColor()
        tb.backgroundColor = UIColor.whiteColor()
        tb.frame = self.view.frame
        tb.backgroundColor = self.view.backgroundColor
        tb.delegate = self
        tb.dataSource = self
        self.view.addSubview(tb)
        tb.tableFooterView = UIView()  //空行不限是线条
        
        tb.registerClass(UITableViewCell.self, forCellReuseIdentifier: Identity)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: nil, action: nil)
        loadData()
    }
    
    
    func loadData(){
        let lc = CommonUtil.lcInfo
        var temp = [String]()
        for li in lc{
            if li.priName == privince{
                temp.append(li.cityName)
            }
        }
        for s in temp{
            if citys.contains(s){
                continue
            }else{
                citys.append(s)
            }
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Identity, forIndexPath: indexPath)
        
        cell.textLabel?.text = citys[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citys.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        CommonUtil.currCity = citys[indexPath.row]
        
        let qu = QuViewController()
        self.navigationController?.pushViewController(qu, animated: true)

    }
}
