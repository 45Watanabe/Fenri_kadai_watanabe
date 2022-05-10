//
//  GourmandModel.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/04/29.
//

import Foundation
import SwiftUI
import MapKit

class GourmandModel: ObservableObject {
    static let gourmandModel = GourmandModel()
    private init() {}
    
    @Published var mobileLocation = (lat: 0.0, lng: 0.0)
    @Published var Gourmands: [Gourmand] = []
    @Published var pins: [PinItem] = []
    @Published var ImageList: [UIImage] = []
    @Published var selected = ""

    @Published var isDispInfo = false
    @Published var dispInfoNum = 0
    @Published var pickUpPhoto: UIImage = UIImage(systemName: "icloud.and.arrow.down.fill")!
    
    
    func pushInfoButton(name: String, image: UIImage) {
        var count = 0
        for num in 0..<Gourmands.count {
            if Gourmands[num].name != name {
                count += 1
            } else {
                break
            }
        }
        dispInfoNum = count
        pickUpPhoto = image
        isDispInfo = true
    }
    
    func pushCloseInfoButton() {
        isDispInfo = false
    }
    
    func getGourmandData(lat: Double, lng: Double, count: Int) {
        
        guard let req_url = URL(string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=62aeec437d81f467&lat=\(lat)&lng=\(lng)&range=10&count=\(count)&format=json") else {
            return
        }
        print(req_url)
        
        // リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        // データ転送を管理するためのセッションを生成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        // リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, response ,error) in
            // セッションを終了
            session.finishTasksAndInvalidate()
            // do try catch エラーハンドリング
            do {
                // JSONDecoderのインスタンス取得
                let decoder = JSONDecoder()
                // 受け取ったJSONデータをパース（解析）して格納
                let json = try decoder.decode(Response.self, from: data!)
                print("------------json-------------")
                print(json)
                self.Gourmands = [] //情報のリセット
                self.pins = [] //ピンのリセット
                self.selected = ""
                
                for i in 0..<json.results.shop.count {
                    self.Gourmands.append(Gourmand(name: json.results.shop[i].name,
                                                   address: json.results.shop[i].address,
                                                   photoUrl: json.results.shop[i].photo.mobile.s,
                                                   catch: json.results.shop[i].`catch`,
                                                   open: json.results.shop[i].`open`,
                                                   access: json.results.shop[i].access,
                                                   card: json.results.shop[i].card,
                                                   child: json.results.shop[i].child,
                                                   close: json.results.shop[i].close,
                                                   non_smoking: json.results.shop[i].non_smoking,
                                                   parking: json.results.shop[i].parking,
                                                   pet: json.results.shop[i].pet,
                                                   urls: json.results.shop[i].urls.pc,
                                                   lat: json.results.shop[i].lat,
                                                   lng: json.results.shop[i].lng))
                    print("-------------\(i+1)件名-------------")
                    print(self.Gourmands[i])
                    
                    // マーカーの生成
                    let item = PinItem(name: json.results.shop[i].name,
                                       coordinate: .init(latitude: json.results.shop[i].lat,
                                                         longitude: json.results.shop[i].lng))
                    self.pins.append(item)
                }
                
            } catch {
                // エラー処理
                print("エラーが出ました")
            }
        })
        // ダウンロード開始
        task.resume()
    }
}

//構造体
struct Response: Decodable {
    
    let results: Results
    struct Results: Decodable {
        let api_version: String
        let results_returned: String
        let shop: [Shop]
        struct Shop: Decodable {
            let access: String
            let address: String
            let `catch`: String
            let card: String
            let child: String
            let close: String
            let lat: Double
            let lng: Double
            let name: String
            let non_smoking: String
            let open: String
            let parking: String
            let pet: String
            let photo: Photo
            let urls: Urls
        }
        struct Photo: Decodable {
            let mobile: Mobile
            struct Mobile: Decodable {
                let l: String
                let s: String
            }
        }
        struct Urls: Decodable {
            let pc: String
        }
    }
}


// 確認しやすい順番で宣言
struct Gourmand {
    let name: String
    let address: String
    let photoUrl: String
    let `catch`: String
    let `open`: String
    let access: String
    
    let card: String
    let child: String
    let close: String
    let non_smoking: String
    let parking: String
    let pet: String
    
    let urls: String
    let lat: Double
    let lng: Double
}

struct PinItem: Identifiable {
    var id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
