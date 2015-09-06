//
//  TableMenuView.swift
//  TableMenuView
//
//  Created by duzhe on 15/9/5.
//  Copyright (c) 2015年 duzhe. All rights reserved.
//
import UIKit


protocol MenuViewDelegate {

/**
*  获取第class级菜单的数据数量
*
*  @param asView 联想菜单
*  @param idx    第几级
*
*  @return 第class级菜单的数据数量
*/
func assciationMenuView(asView:TableMenuView , countForClass idx:Int) -> Int;

/**
*  获取第一级菜单选项的title
*
*  @param asView 联想菜单
*  @param idx_1  第一级
*
*  @return 标题
*/
func assciationMenuView(asView:TableMenuView,titleForClass_1 idx_1:Int)->String


}

class TableMenuView:UIView,UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    private let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
    private let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
    private let IDENTIFIER = "cell"
    var delegate:MenuViewDelegate?
    var sels = [0,0]
    
    var tables = [UITableView]()
    var bgView:UIView
    
    init(){
        
        // 初始化选择项
        for i in 0...1 {
            sels[i] = -1;
        }
        bgView = UIView()
        super.init(frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.userInteractionEnabled = true;
        
        //初始化tables 二级菜单放两份
        tables = [UITableView(),UITableView()]
        for table in tables{
            //注册cell
           // table.registerClass(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: IDENTIFIER)
            table.dataSource = self
            table.delegate = self
            table.frame = CGRectMake(0, 0, 0, 0)
            table.backgroundColor = UIColor.clearColor()
            table.tableFooterView = UIView()
        }
        bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        bgView.userInteractionEnabled = true;
        bgView.addSubview(tables[0])
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
    
    /**
    *  设置选中项，-1为未选中
    *
    *  @param idx_1  第一级选中项
    *  @param idx_2  第二级选中项
    */
    func setSelectIndexForClass1(class1 idx_1:Int , class2 idx_2:Int)
    {
        sels[0] = idx_1;
        sels[1] = idx_2;
    }
    
    //点击cell
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cont:Int = 0
        if let dele = delegate{
            for (k,table) in tables.enumerate(){
                if(table == tableView) {
                    cont = (dele.assciationMenuView(self,countForClass:k))
                    //*stop = YES;
                }
            }
        }
        return cont
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(IDENTIFIER)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: IDENTIFIER)
        }
        if(tableView == tables[0]){
            print("ssw")
           cell!.textLabel!.text = "swaaaaa"
        }else if(tableView == tables[1]){
             print("aaw")
            cell!.textLabel!.text = "zheng"
        }
        return cell!
    }
    
    
    func showAsView(){
        bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        if((bgView.superview) != nil) {
//           
//        }
        
         self.addSubview(bgView)
        loadSels()
        adjustTableViews()
        if(self.superview == nil) {
            UIApplication.sharedApplication().keyWindow?.addSubview(self)
            self.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.alpha = 1.0
            })
            
        }
        UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(self)
    }
    
    func adjustTableViews(){
        
        var showCount = 0
        for (_ ,table) in tables.enumerate(){
            var rect = table.frame;
            rect.size.height = SCREEN_HEIGHT - bgView.frame.origin.y;
            table.frame = rect;
            if(table.superview != nil){
                ++showCount
            }
        }
        for i in 1...showCount{
            let t = tables[i-1]
            var f = t.frame
            f.size.width = SCREEN_WIDTH / CGFloat(showCount);
            f.origin.x = f.size.width * CGFloat(i);
            t.frame = f;
        }
    }
    
    func loadSels(){
        for (k,table) in tables.enumerate(){
           table.selectRowAtIndexPath(NSIndexPath(forItem: k, inSection: 0), animated: true,           scrollPosition: UITableViewScrollPosition.None)
            if sels[k] != -1 && table.superview != nil || k != 0 {
                bgView.addSubview(table)
            }
        }
    }
}