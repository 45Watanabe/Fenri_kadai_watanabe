//
//  HomeView.swift
//  Gourmand
//
//  Created by 渡辺幹 on 2022/04/29.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var gm: GourmandModel = .gourmandModel
    @ObservedObject var hvm = HomeViewModel()
    var body: some View {
        GeometryReader { geometry in
            let w = geometry.size.width
            let h = geometry.size.height
            ZStack{
                MapView()
                VStack(spacing:0){
                    HStack{
                        Spacer()
                        HStack{
                            VStack{
                                Text("最大表示件数")
                                    .foregroundColor(Color.black)
                                HStack{
                                    Button(action: {
                                        hvm.pushArrowButton(push: "countMinus")
                                    }){
                                        Text("<")
                                            .fontWeight(.bold)
                                    }
                                    Text("\(hvm.maxGourmand)件")
                                    Button(action: {
                                        hvm.pushArrowButton(push: "countPlus")
                                    }){
                                        Text(">")
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                            VStack{
                                Text("検索範囲")
                                    .foregroundColor(Color.black)
                                HStack{
                                    Button(action: {
                                        hvm.pushArrowButton(push: "rangeMinus")
                                    }){
                                        Text("<")
                                            .fontWeight(.bold)
                                    }
                                    Text("\(hvm.rangeList[hvm.searchRange])m")
                                    Button(action: {
                                        hvm.pushArrowButton(push: "rangePlus")
                                    }){
                                        Text(">")
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                        }.padding(5)
                        .background(Color.white)
                        .border(Color.black)
                        
                    }
                    
                    Spacer()
                        .frame(width: w*0.95,
                               height: hvm.tenkai ? h*0.2:h*0.85)
                    HStack{
                        Button(action: {hvm.tenkai.toggle()}){
                            Image(systemName: hvm.tenkai ?
                                  "chevron.down.square.fill":"chevron.up.square.fill")
                                .resizable()
                                .frame(width: 50, height: 30)
                                .foregroundColor(Color.black)
                        }
                        Spacer()
                        Button(action: {
                            hvm.pushSearchButton()
                        }){
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                                .foregroundColor(Color.black)
                        }
                        Button(action: {
                            hvm.pushSearchButton()
                        }){
                            Image(systemName: "goforward")
                                .font(.title)
                                .foregroundColor(Color.black)
                        }
                    }.animation(.default, value: hvm.tenkai)
                    
                    if gm.isDispInfo {
                        RestaurantInfoView(dispNum: gm.dispInfoNum)
                            .border(Color.black)
                            .ignoresSafeArea()
                            .animation(.default, value: hvm.tenkai)
                    } else {
                        RestaurantGridView()
                            .border(Color.black)
                            .ignoresSafeArea()
                            .animation(.default, value: hvm.tenkai)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
