//
//  ViewController.swift
//  ToEatGourmand
//
//  Created by 渡辺幹 on 2022/05/06.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CLLocationを使って位置情報を取得。
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        locationManager!.requestWhenInUseAuthorization()
        
        //位置情報を使用可能か
        if CLLocationManager.locationServicesEnabled() {
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.distanceFilter = 10
            locationManager!.activityType = .fitness
            locationManager!.startUpdatingLocation()
        }
    }
    
    var gm: GourmandModel = .gourmandModel
    
    // 位置情報が変わるたびに 変数:mobileLocation を更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            return
        }
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        
        gm.mobileLocation.lat = Double(location.latitude)
        gm.mobileLocation.lng = Double(location.longitude)
        print("緯度: ", location.latitude, "経度: ", location.longitude)

    }
    
    // 画面遷移
    @IBAction func startButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showNext", sender: nil)
    }
    
}

