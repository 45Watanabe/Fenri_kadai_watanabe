//
//  GourmandModel.swift
//  ToEatGourmand
//
//  Created by 渡辺幹 on 2022/05/07.
//

import Foundation
import MapKit

class GourmandModel {
    static let gourmandModel = GourmandModel()
    private init() {}
    
    var mobileLocation = (lat: 0.0, lng: 0.0)
    var Gourmands: [Gourmand] = []
    var pins: [PinItem] = []
    var imgLoader: ImageLoader = .imageLoader
    
    // HomeViewModelから起動
    func executionGetData(range: Int, count: Int, handler: @escaping ()->()){
        getGourmandData(lat: mobileLocation.lat, lng: mobileLocation.lng,
                        range: range, count: count, handler: handler)
    }
    
    // APIからデータの取得
    func getGourmandData(lat: Double, lng: Double, range: Int, count: Int, handler: @escaping ()->()) {
        
        guard let req_url = URL(string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=62aeec437d81f467&lat=\(lat)&lng=\(lng)&range=\(range)&count=\(count)&format=json") else {
            return
        }
        print(req_url)
        
        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: req, completionHandler: {
            (data, response ,error) in
            session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(Response.self, from: data!)
                print("------------json-------------")
                print(json)
                //情報のリセット
                self.Gourmands = []
                self.pins = []
                
                // データの格納
                for i in 0..<json.results.shop.count {
                    self.Gourmands.append(Gourmand(name: json.results.shop[i].name,
                                                   address: json.results.shop[i].address,
                                                   catch: json.results.shop[i].`catch` == "" ?
                                                            "~キャッチコピー: 無し~" : json.results.shop[i].`catch`,
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
                    
                    // imageLoaderで画像を取得
                    self.imgLoader.setImage(photoURL: json.results.shop[i].photo.mobile.l, num: i)
                    
                    print("-------------\(i+1)件名-------------")
                    print(self.Gourmands[i])
                    
                    // マーカーの生成
                    let item = PinItem(name: json.results.shop[i].name,
                                       coordinate: .init(latitude: json.results.shop[i].lat,
                                                         longitude: json.results.shop[i].lng))
                    self.pins.append(item)
                }
                for n in 0..<self.Gourmands.count {
                    self.Gourmands[n].photo = self.imgLoader.imageList[n]
                }
                
                // 少し時間を空けてreloadData
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    handler()
                }
            } catch {
                print("エラーが出ました")
            }
        })
        task.resume()
    }
}

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


struct Gourmand {
    let name: String
    let address: String
    let `catch`: String
    let open: String
    let access: String
    var photo: UIImage = UIImage(systemName: "icloud.and.arrow.down.fill")!
    
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
