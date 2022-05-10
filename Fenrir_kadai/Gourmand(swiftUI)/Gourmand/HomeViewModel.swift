//
//  HomeViewModel.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/05/05.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @ObservedObject var gm: GourmandModel = .gourmandModel
    @Published var tenkai = false
    @Published var maxGourmand = 10
    let rangeList = [0, 300, 500, 1000, 2000, 3000]
    @Published var searchRange = 2
    
    func pushArrowButton(push: String) {
        if push == "countPlus" && maxGourmand < 20{
            maxGourmand += 1
        }
        if push == "countMinus" && maxGourmand > 1{
            maxGourmand -= 1
        }
        if push == "rangePlus" && searchRange < 5{
            searchRange += 1
        }
        if push == "rangeMinus" && searchRange > 1{
            searchRange -= 1
        }
    }
    
    func pushSearchButton() {
        gm.getGourmandData(lat: gm.mobileLocation.lat,
                           lng: gm.mobileLocation.lng,
                           count: maxGourmand)
    }
    
    
}
