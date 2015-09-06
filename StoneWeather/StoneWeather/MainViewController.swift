//
//  MainViewController.swift
//  StoneWeather
//
//  Created by duzhe on 15/9/5.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var cityName: UILabel! //城市名称
    @IBOutlet weak var degree: UILabel!  //温度
    @IBOutlet weak var adressDetail: UILabel!   //当前详细地址
    
//    @IBOutlet weak var aq: UILabel!
//    
//    @IBOutlet weak var co1: UILabel!
//    
//    @IBOutlet weak var co2: UILabel!
//    
//    @IBOutlet weak var o3: UILabel!
//    
    var weather:WeatherBaseInfo?
//
//    @IBOutlet weak var pm25: UILabel!
//    
//    @IBOutlet weak var so2: UILabel!
//    @IBOutlet weak var aqtype: UILabel!
    let locationManager:CLLocationManager = CLLocationManager() //实例化一个CLLocationManager对象

    let geocoder = CLGeocoder(); //用来获取城市名称的

    override func viewDidLoad() {
        super.viewDidLoad()
        //后台提前加载数据存到内存
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            CommonUtil.excuteToLocation("citys")
        }

        handleData()
        configLocation()
        
        UINavigationBar.appearance().barTintColor = self.view.backgroundColor
    }
    
    func configLocation(){
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //设置为最高的精度
        if(ios8()){
            locationManager.requestAlwaysAuthorization()  //如果是IOS8及以上版本需调用这个方法
            //locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()  //start updating location
    }
    
    //是否大于ios 8.0
    func ios8() -> Bool {
        let  versionCode = UIDevice.currentDevice().systemVersion
        let res = versionCode.compare("8.0.0", options: NSStringCompareOptions.NumericSearch)
        switch res{
        case .OrderedDescending,.OrderedSame:
            return true
        case .OrderedAscending:
            return false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        handleData()
    }
    
    func handleData(){
       // let httpArg = "shanghai"
        let req = CommonUtil.request(CommonUtil.currArea)
        
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) -> Void in
            if let e = error{
                print("请求失败\(e)")
                return
            }
            let res = response as? NSHTTPURLResponse
            print(res?.statusCode)
            if let d = data {
//                let content = NSString(data: d, encoding: NSUTF8StringEncoding)
//                print(content)
                //请求成功， 处理json数据
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                    if let info = (json!.valueForKey("HeWeather data service 3.0") as? [AnyObject])
                    {
                        if let  detail = (info[0] as? NSDictionary){
                            if (detail.valueForKey("status") as! String).lowercaseString == "ok"{
                                //成功！！
                                let basic: AnyObject? = detail.valueForKey("basic")
                                let now: AnyObject? = detail.valueForKey("now")
                                 let aqi: AnyObject? = detail.valueForKey("aqi")?.valueForKey("city")
                                //给weather对象赋值
                                self.weather = WeatherBaseInfo(cityName:basic!.valueForKey("city")! as!
                                    String,tempDegree:now!.valueForKey("tmp")! as! String)
                                
                                self.weather?.aqi.aqi = aqi?.valueForKey("aqi") as? String
                                self.weather?.aqi.co = aqi?.valueForKey("co") as? String
                                self.weather?.aqi.no2 = aqi?.valueForKey("no2") as? String
                                self.weather?.aqi.o3 = aqi?.valueForKey("aqi") as? String
                                self.weather?.aqi.pm25 = aqi?.valueForKey("pm25") as? String
                                self.weather?.aqi.qlty = aqi?.valueForKey("qlty") as? String
                                self.weather?.aqi.so2 = aqi?.valueForKey("so2") as? String
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    
                                    if CommonUtil.currCity == self.weather!.cityName {
                                        self.cityName.text = "\(self.weather!.cityName)"
                                    }else{
                                        self.cityName.text = "\(CommonUtil.currCity) \(self.weather!.cityName)"
                                    }
                                    self.degree.text = self.weather!.tempDegree + " °C"
//                                    self.aq.text =  (self.weather!.aqi.aqi)
//                                    self.co1.text = (self.weather!.aqi.co)
//                                    self.co2.text = self.weather?.aqi.no2
//                                    self.o3.text = self.weather?.aqi.o3
//                                    self.pm25.text = self.weather?.aqi.pm25
//                                    self.aqtype.text = self.weather?.aqi.qlty
//                                    self.so2.text = self.weather?.aqi.so2
                           
                                })
                                
                            }
                        }
                    }
                    
                }catch{
                    print("json处理异常")
                }
            }
        }
    }
    
    //重写这个方法获取位置
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        print("get location")
        let location:CLLocation = locations[locations.count - 1] as! CLLocation //得到数组中的最后一个元素
        if location.horizontalAccuracy > 0 {
            let latitude = location.coordinate.latitude  //得到经伟度
            let longtitude = location.coordinate.longitude
            locationManager.stopUpdatingLocation() //stop updating location
            
            geocoder.reverseGeocodeLocation(locations[0] as! CLLocation, completionHandler: { (arrs, error) -> Void in
                if arrs!.count > 0 {
                   // print(arrs[0])
                    if let ps = arrs{
                        for placemark in ps {
                            print(placemark.name)
                            self.adressDetail.text = " \(placemark.name)"
                            print(placemark.locality)

                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),{
                                
                                for info in CommonUtil.lcInfo{
                                    if placemark.locality.hasPrefix(info.quName){
                                        CommonUtil.currArea = info.localCode
                                        self.handleData()
                                    }
                                }
                            })
                            
                        }
                    }
                }
            })
            print("\(latitude),\(longtitude)")
        }
    }
    
    //重写当发生错误时要调用的方法
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }

    
    
}
