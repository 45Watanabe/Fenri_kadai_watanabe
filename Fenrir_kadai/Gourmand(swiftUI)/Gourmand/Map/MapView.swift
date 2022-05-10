//
//  MapView.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/04/29.
//
// 以下の行を追加
import SwiftUI
import CoreLocation
import MapKit

struct MapView: View {
    @ObservedObject var gm: GourmandModel = .gourmandModel
    @State var region = MKCoordinateRegion()
    @State var userTrackingMode: MapUserTrackingMode = .follow
    var body: some View {
        ZStack{
            // 設定モリモリモード
            // interactionModes .allでピンチもスワイプもOK
            // showUserLocation trueでユーザの現在地表示
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode,
                annotationItems: gm.pins,
                annotationContent: { element in
                MapAnnotation(coordinate: element.coordinate,anchorPoint: CGPoint(x: 0.5, y: 0.5),
                              content: {
                    Button(action: {
                        gm.selected = element.name
                    }){
                        if gm.selected == element.name {
                            Image(systemName: "mappin")
                                .font(.system(size: 70))
                                .foregroundColor(Color.red)
                        } else {
                            Image(systemName: "mappin")
                                .font(.system(size: 50))
                                .foregroundColor(Color.blue)
                        }
                    }
                })
            }
            )
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
