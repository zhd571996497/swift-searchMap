//
//  ViewController.swift
//  SearchMap
//
//  Created by 朱宏达 on 16/3/7.
//  Copyright © 2016年 朱宏达. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func btnSupermarketClick(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("supermarket")
        result()
    }
    @IBAction func btnHospital(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("hospital")
        result()
    }
    @IBAction func btnHotelClick(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("hotel")
        result()
    }
    @IBOutlet weak var btnSupermarket: UIButton!
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnHotel: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    // 初始化地理位置
    let intialLocation = CLLocation(latitude: 22.5596260000, longitude: 113.8895060000)
    // 设置搜索范围
    let searchRadius:CLLocationDistance = 4000
    
    @IBAction func btnMenuClick(sender: AnyObject) {
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.btnHotel.alpha = 0.8
            //CGAffineTransformMakeScale(1.5, 1.5)x,y轴缩放倍数
            //CGAffineTransformMakeTranslation  创建一个平移的变化
            //CGAffineTransformMakeRotation     创建一个旋转角度的变化
            self.btnHotel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5), CGAffineTransformMakeTranslation(-80, -25))
            self.btnHospital.alpha = 0.8
            self.btnHospital.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5), CGAffineTransformMakeTranslation(0, -50))
            self.btnSupermarket.alpha = 0.8
            self.btnSupermarket.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5), CGAffineTransformMakeTranslation(80, -25))
            self.btnMenu.transform = CGAffineTransformMakeRotation(0)
            
            }, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnMenu.alpha = 0
        // 对三个按钮的设置
        self.btnHotel.alpha = 0
        self.btnHospital.alpha = 0
        self.btnSupermarket.alpha = 0
        self.btnHotel.layer.cornerRadius = 5
        self.btnHospital.layer.cornerRadius = 5
        self.btnSupermarket.layer.cornerRadius = 5
        UIView.animateWithDuration(1, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.btnMenu.alpha = 1
            self.btnMenu.transform = CGAffineTransformMakeRotation(0.25 * 3.1415927)
            }, completion: nil)
        
        // 创建一个区域
        let region = MKCoordinateRegionMakeWithDistance(intialLocation.coordinate, searchRadius, searchRadius)
        // 设置显示
        mapView.setRegion(region, animated: true)
        searchMap("place")
    }

    func result() {
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.btnHotel.alpha = 0
            self.btnHotel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0))
            self.btnHospital.alpha = 0
            self.btnHospital.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0))
            self.btnSupermarket.alpha = 0
            self.btnSupermarket.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0))
            self.btnMenu.transform = CGAffineTransformMakeRotation(0.25 * 3.1415927)
            
            }, completion: nil)

    }
    
    // 增加兴趣地点
    func addLocation(title:String, latitude:CLLocationDegrees, longtitude:CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        let annotation = myAnnotation(coordinate: location, title: title)
        mapView.addAnnotation(annotation)
    }
    
    // 搜索
    func searchMap(place:String) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        // 搜索当前区域
        let span = MKCoordinateSpanMake(0.1, 0.1)
        request.region = MKCoordinateRegion(center: intialLocation.coordinate, span: span)
        //启动搜索,并且把返回结果保存到数组中
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?,error:NSError?) -> Void in
            for item in (response?.mapItems)! {
                self.addLocation(item.name!, latitude: (item.placemark.location?.coordinate.latitude)!, longtitude: (item.placemark.location?.coordinate.longitude)!)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

