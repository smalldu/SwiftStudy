//
//  PrivinceViewController.swift
//  StoneWeather
//
//  Created by duzhe on 15/9/5.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class PrivinceViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    private let Identity = "cell"
    let tb = UITableView()
    var privinces = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "请选择省份"
        tb.frame = self.view.frame
        tb.backgroundColor = self.view.backgroundColor
        tb.delegate = self
        tb.dataSource = self
        self.view.addSubview(tb)
//        tb.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: Identity)
        tb.registerClass(UITableViewCell.self, forCellReuseIdentifier: Identity)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: nil, action: nil)

        loadData();
    }
    
    func loadData(){
        let lc = CommonUtil.lcInfo
        var temp = [String]()
       // var curPri = ""
        for li in lc{
            temp.append(li.priName)
        }
        
        for s in temp{
            if privinces.contains(s){
                continue
            }else{
                privinces.append(s)
               // curPri = s
            }
        }
        
    }
    
    @IBAction func canCel(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Identity, forIndexPath: indexPath)
        cell.textLabel?.text=privinces[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privinces.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let city = CitysViewController()
        city.privince = privinces[indexPath.row]
        self.navigationController?.pushViewController(city, animated: true)
        
    }
    
}
