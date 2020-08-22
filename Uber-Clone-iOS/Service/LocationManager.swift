//
//  LocationManager.swift
//  Uber-Clone-iOS
//
//  Created by rs on 22.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    var locationManeger = CLLocationManager()
    
    private override init() {
        super.init()
        locationManeger.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManeger.requestAlwaysAuthorization()
        }
    }
}
