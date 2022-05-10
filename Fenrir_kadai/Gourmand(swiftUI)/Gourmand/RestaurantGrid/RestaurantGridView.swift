//
//  RestaurantGridView.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/04/29.
//

import SwiftUI

struct RestaurantGridView: View {
    @ObservedObject var gm: GourmandModel = .gourmandModel
    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                Color.yellow
                VStack(spacing:3){
                    Text(gm.selected == "" ?
                         "[^]を押して展開":"\(gm.selected)")
                    ScrollView{
                        ForEach(0..<10){ i in
                            HitRestaurant(num: i)
                        }
                    }
                }
            }
        }
    }
}

struct HitRestaurant: View {
    @ObservedObject var gm: GourmandModel = .gourmandModel
    let num: Int
    let w = UIScreen.main.bounds.width
    
    @State var image: UIImage?
    
    var body: some View {
        if gm.Gourmands.count > num {
            ZStack{
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            gm.pushInfoButton(name: gm.Gourmands[num].name,
                                              image: image!)
                        }){
                            Image(systemName: "info.circle")
                                .font(.title2)
                                .padding(5)
                        }
                    }
                    Spacer()
                }
                VStack{
                    HStack{
                        
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: w*0.2, height: w*0.2)
                        }
                        VStack(spacing:0){
                            Text("\(gm.Gourmands[num].name)")
                                .font(.body)
                            Group{
                                Text(gm.Gourmands[num].`catch`)
                                Text("定休日：\(gm.Gourmands[num].close)")
                            }.font(.caption)
                        }.frame(width: w*0.7)
                    }
                    Text("\(gm.Gourmands[num].access)")
                        .font(.caption)
                }
            }
            .frame(width: w*0.95, height: w*0.4)
                .border(
                    gm.selected == gm.Gourmands[num].name ?
                    Color.red:Color.black, width: 2)
                .background(
                    gm.selected == gm.Gourmands[num].name ?
                    Color.gray:Color.white)
                .onTapGesture {
                    gm.selected = gm.Gourmands[num].name
                }
            
                .onAppear(){
                    let url = gm.Gourmands[num].photoUrl
                    downloadImageAsync(url: URL(string: url)!) { image in
                        self.image = image
                    }
                }
            
        }
    }
    
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

struct RestaurantGridView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantGridView()
    }
}
