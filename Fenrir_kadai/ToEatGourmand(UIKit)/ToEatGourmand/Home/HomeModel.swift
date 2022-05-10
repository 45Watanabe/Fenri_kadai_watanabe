//
//  HomeModel.swift
//  ToEatGourmand
//
//  Created by 渡辺幹 on 2022/05/07.
//

import Foundation

class HomeModel {
    var gm: GourmandModel = .gourmandModel
    var range = 2
    var count = 10
    let rangeList = [0, 300, 500, 1000, 2000, 3000]
    
    // 最大件数/検索範囲の増減
    func pushArrowButton(push: String) -> Int {
        var result = push.prefix(1) == "c" ? count:rangeList[range]
        if push == "countPlus" && count < 20{
            count += 1
            result = count
        }
        if push == "countMinus" && count > 5{
            count -= 1
            result = count
        }
        if push == "rangePlus" && range < 5{
            range += 1
            result = rangeList[range]
        }
        if push == "rangeMinus" && range > 1{
            range -= 1
            result = rangeList[range]
        }
        return result
    }
    
    // グルメの検索
    func pushSearchButton(_ handler: @escaping ()->()) {
        gm.executionGetData(range: range, count: count, handler: handler)
    }
    
}
