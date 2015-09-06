//
//  ViewController.swift
//  NetDemo
//
//  Created by duzhe on 15/9/4.
//  Copyright (c) 2015年 duzhe. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController ,CLLocationManagerDelegate{

    @IBOutlet weak var cityName: UILabel! //城市名称
    @IBOutlet weak var degree: UILabel!  //温度
    var weather:WeatherBaseInfo?
    let locationManager:CLLocationManager = CLLocationManager() //实例化一个CLLocationManager对象
    let geocoder = CLGeocoder(); //用来获取城市名称的
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleData()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //设置为最高的精度
        if(ios8()){
            locationManager.requestAlwaysAuthorization()  //如果是IOS8及以上版本需调用这个方法
            //locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()  //start updating location
        
        
    }

    func handleData(){
        var httpArg = "shanghai"
        let req = CommonUtil.request(httpArg)
        
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) -> Void in
            if let e = error{
                println("请求失败\(e)")
                return
            }
            let res = response as? NSHTTPURLResponse
            println(res?.statusCode)
            if let d = data {
                var content = NSString(data: d, encoding: NSUTF8StringEncoding)

                //请求成功， 处理json数据
                if let json = NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary{
                    
                    if let info = (json.valueForKey("HeWeather data service 3.0") as? [AnyObject])
                    {
                        if let  detail = (info[0] as? NSDictionary){
                        
                            if (detail.valueForKey("status") as! String).lowercaseString == "ok"{
                            
                                //成功！！
                                let basic: AnyObject? = detail.valueForKey("basic")
                                let now: AnyObject? = detail.valueForKey("now")
                                let daily_forecast:AnyObject?  = detail.valueForKey("daily_forecast")
                                
                                //print(basic?.valueForKey("city"))
                                //print(now?.valueForKey("cond"))  //天气状况
                                //print(daily_forecast) //温度
                                
                                self.weather = WeatherBaseInfo(cityName:basic!.valueForKey("city")! as! String,tempDegree:now!.valueForKey("tmp")! as! String)
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.cityName.text =  self.weather?.cityName
                                    self.degree.text = self.weather!.tempDegree + " °C"
                                })
                                
                            }
                        }
                    }
                }
                //println(content)
            }
        }
    }
    
    func readJson()->NSArray?{
        if let path = NSBundle.mainBundle().pathForResource("citys", ofType: "json") {
            print("dudao")
            var error: NSError?
            let data: NSData? = NSData(contentsOfFile: path, options: NSDataReadingOptions(), error: &error)
            if let data = data {
                
                let array: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: &error)
                if let array = array as? NSArray {
                    return array
                } else {
                    println("file '(filename)' is not valid JSON: (error!)")
                    return nil
                }
            } else {
                println("Could not load file: (filename), error: (error!)")
                 return nil
            }
        } else {
            println("Could not find file: (filename)")
             return nil
        }
    }
    
    //是否大于ios 8.0
    func ios8() -> Bool {
        var  versionCode = UIDevice.currentDevice().systemVersion
        var res = versionCode.compare("8.0.0", options: NSStringCompareOptions.NumericSearch)
        switch res{
        case .OrderedDescending,.OrderedSame:
            return true
        case .OrderedAscending:
            return false
        }
    }
    
    //重写这个方法获取位置
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("get location")
        let location:CLLocation = locations[locations.count - 1] as! CLLocation //得到数组中的最后一个元素
        if location.horizontalAccuracy > 0 {
            let latitude = location.coordinate.latitude  //得到经伟度
            let longtitude = location.coordinate.longitude
            locationManager.stopUpdatingLocation() //stop updating location
            
            geocoder.reverseGeocodeLocation(locations[0] as! CLLocation, completionHandler: { (arrs, error) -> Void in
                print(arrs)
//                if arrs.count > 0 {
//                    var placemark:CLPlacemark = arrs[0] as! CLPlacemark
//                    print(placemark.name)
//                    print(placemark.locality)
//                    print(placemark.administrativeArea)
//                }
            })
            
            print("\(latitude),\(longtitude)")
        }
    }
    
    //重写当发生错误时要调用的方法
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
         println(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

