//
//  ImageLoader.swift
//  ToEatGourmand
//
//  Created by 渡辺幹 on 2022/05/09.
//

import Foundation
import UIKit

class ImageLoader {
    static let imageLoader = ImageLoader()
    private init(){}
    
    var imageList: [UIImage] = []
    
    // 画像の取得を命令、取得した画像をimageListに格納
    func setImage(photoURL: String, num: Int) {
        if num == 0 { imageList = [] }
        self.imageList.append(UIImage(systemName: "icloud.and.arrow.down.fill")!)
        let url = photoURL
        downloadImageAsync(url: URL(string: url)!) { image in
            self.imageList[num] = image!
        }
    }
    
    // URLを元に画像を取得
    func downloadImageAsync(url: URL, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, _, _) in
            var image: UIImage?
            if let imageData = data {
                image = UIImage(data: imageData)
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
