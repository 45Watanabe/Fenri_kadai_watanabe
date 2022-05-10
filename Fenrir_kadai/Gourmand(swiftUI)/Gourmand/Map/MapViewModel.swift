//
//  MapViewModel.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/05/05.
//

import SwiftUI
import Foundation
import MapKit


/// ViewModel
class ViewModel:ObservableObject{
    
    //@Published var pins: [PinItem] = []
    // Viewに表示するのでPublished
    /// 現在地……勝手に追尾するので今いらない状態
    /// 位置情報を許可しないと南太平洋に連れて行かれる
    @Published var region = MKCoordinateRegion()
    // Viewに表示するのでPublished
    /// ユーザの追跡をするか(.followで追跡)
    /// 向きを表示するfollowWithHeadingはSwiftUIで消失しました。
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    
    
        
        
    
}
    

