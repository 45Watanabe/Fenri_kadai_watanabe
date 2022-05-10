//
//  RestaurantInfoView.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/04/29.
//

import SwiftUI

struct RestaurantInfoView: View {
    @ObservedObject var gm: GourmandModel = .gourmandModel
    @State var dispNum: Int
    var body: some View {
        GeometryReader { geometry in
            let w = geometry.size.width
            let h = geometry.size.height
            ZStack{
                Color.yellow
                VStack(spacing:3){
                    HStack{
                        Button(action: {
                            gm.pushCloseInfoButton()
                        }){
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                .font(.title2)
                        }
                        Spacer()
                    }
                    ScrollView{
                        VStack{
                            Text("\(gm.Gourmands[dispNum].name)")
                                .font(.title2)
                            HStack{
                                Spacer()
                                Text("\(gm.Gourmands[dispNum].address)")
                                    .font(.caption)
                            }
                            Image(uiImage: gm.pickUpPhoto)
                                .resizable()
                                .frame(width: w*0.6, height: w*0.6)
                                .background(Color.gray)
                            HStack{
                                Text("キャッチ").font(.caption)
                                Spacer()
                            }
                            Text("\(gm.Gourmands[dispNum].`catch`)")
                            HStack{
                                Text("営業時間").font(.caption)
                                Spacer()
                            }
                            Text("\(gm.Gourmands[dispNum].`open`)")
                            HStack{
                                Text("アクセス").font(.caption)
                                Spacer()
                            }
                            Text("\(gm.Gourmands[dispNum].access)")
                            
                            Group{
                                HStack{
                                    miniInfo(tag: "お子様連れ", text: "\(gm.Gourmands[dispNum].child)")
                                    miniInfo(tag: "タバコ", text: "\(gm.Gourmands[dispNum].non_smoking)")
                                }
                                HStack{
                                    miniInfo(tag: "パーキング", text: "\(gm.Gourmands[dispNum].parking)")
                                    miniInfo(tag: "ペット連れ", text: "\(gm.Gourmands[dispNum].pet)")
                                }
                            }
                        }
                        .frame(width: w*0.9, height: h*0.9)
                        .background(Color.white)
                    }
                }
                
            }
        }
        
    }
}

struct miniInfo: View {
    @State var tag: String
    @State var text: String
    var body: some View {
        VStack(spacing: 0){
            Text("\(tag)").font(.caption2)
            Text("\(text)").underline()
        }.padding(3)
    }
}
