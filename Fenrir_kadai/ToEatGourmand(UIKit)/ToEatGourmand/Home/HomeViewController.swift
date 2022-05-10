//
//  HomeViewViewController.swift
//  ToEatGourmand
//
//  Created by 渡辺幹 on 2022/05/07.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, UITableViewDelegate,
                            UITableViewDataSource {
    let hm = HomeModel()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchRangeLabel: UILabel!
    @IBOutlet weak var maxCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(latitude: hm.gm.mobileLocation.lat,
                                              longitude: hm.gm.mobileLocation.lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location,span: span)
    
        mapView.region = region
    }
    
    // pinsを基にマップ上にピンの表示/削除
    func dispPins() {
        for restaurant in hm.gm.pins {
            let pin = MKPointAnnotation()
            pin.title = restaurant.name
            pin.coordinate = restaurant.coordinate
            mapView.addAnnotation(pin)
        }
    }
    
    
    @IBAction func rangePlus(_ sender: Any) {
        searchRangeLabel.text = String(hm.pushArrowButton(push: "rangePlus"))+"m"
    }
    @IBAction func rangeMinus(_ sender: Any) {
        searchRangeLabel.text = String(hm.pushArrowButton(push: "rangeMinus"))+"m"
    }
    @IBAction func countPlus(_ sender: Any) {
        maxCountLabel.text = String(hm.pushArrowButton(push: "countPlus"))+"件"
    }
    @IBAction func countMinus(_ sender: Any) {
        maxCountLabel.text = String(hm.pushArrowButton(push: "countMinus"))+"件"
    }
    
    @IBAction func searchButon(_ sender: Any) {
        hm.pushSearchButton{
            self.refreshMap()
        }
    }
    @IBAction func refreshButton(_ sender: Any) {
        refreshMap()
    }
    
    func refreshMap() {
        tableView.reloadData()
        dispPins()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hm.gm.Gourmands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        
        let photoImage = cell.viewWithTag(1) as! UIImageView
        let image = hm.gm.imgLoader.imageList[indexPath.row]
        photoImage.image = image

        let nameLabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = hm.gm.Gourmands[indexPath.row].name

        let catchLabel = cell.viewWithTag(3) as! UILabel
       catchLabel.text = hm.gm.Gourmands[indexPath.row].`catch`

        let openLabel = cell.viewWithTag(4) as! UILabel
        openLabel.text = hm.gm.Gourmands[indexPath.row].`open`

       let addressLabel = cell.viewWithTag(5) as! UILabel
        addressLabel.text = hm.gm.Gourmands[indexPath.row].address
        
        return cell
    }
    
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    var pushInfoNum = 0
    @IBAction func infoButton(_ sender: UIButton) {
        if let indexPath = tableView.indexPath(for: sender.superview!.superview
                                               as! UITableViewCell){
                    print(indexPath)
            pushInfoNum = indexPath[1]
                } else {
                    print("indexPath in not found")
                }
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo" {
            let nextView = segue.destination as! InfoViewController
            nextView.dispNum = pushInfoNum
        }
    }
}
