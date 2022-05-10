//
//  MapModel.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/05/05.
//

import SwiftUI
import CoreLocation


class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    var locationManager : CLLocationManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        locationManager!.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.distanceFilter = 10
            locationManager!.activityType = .fitness
            locationManager!.startUpdatingLocation()
        }
        
        return true
    }
    
    @ObservedObject var gm: GourmandModel = .gourmandModel
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            return
        }
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        
        gm.mobileLocation.lat = Double(location.latitude)
        gm.mobileLocation.lng = Double(location.longitude)
        print("緯度: ", location.latitude, "経度: ", location.longitude)

    }
    
}
