//
//  myAnnotation.swift
//  SearchMap
//
//  Created by 朱宏达 on 16/3/7.
//  Copyright © 2016年 朱宏达. All rights reserved.
//

import UIKit
import MapKit
class myAnnotation: NSObject,MKAnnotation {
    var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title:String!
    init(coordinate:CLLocationCoordinate2D, title:String) {
        self.coordinate = coordinate
        self.title = title
    }
}
