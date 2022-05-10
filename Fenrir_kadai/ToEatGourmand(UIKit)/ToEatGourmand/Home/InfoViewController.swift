//
//  InfoViewController.swift
//  ToEatGourmand
//
//  Created by 渡辺幹 on 2022/05/09.
//

import UIKit

class InfoViewController: UIViewController {
    var ivm = InfoViewModel()
    var dispNum = 1
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var nameLael: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var catchLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var childLabel: UILabel!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var smokingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantImage.image = ivm.gm.imgLoader.imageList[dispNum]
        nameLael.text = ivm.gm.Gourmands[dispNum].name
        addressLabel.text = ivm.gm.Gourmands[dispNum].address
        catchLabel.text = ivm.gm.Gourmands[dispNum].`catch`
        openLabel.text = ivm.gm.Gourmands[dispNum].`open`
        accessLabel.text = ivm.gm.Gourmands[dispNum].access
        
        cardLabel.text = ivm.gm.Gourmands[dispNum].card
        childLabel.text = ivm.gm.Gourmands[dispNum].child
        parkingLabel.text = ivm.gm.Gourmands[dispNum].parking
        smokingLabel.text = ivm.gm.Gourmands[dispNum].non_smoking
    }
}
