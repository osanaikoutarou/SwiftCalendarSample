//
//  MonthModel.swift
//  SwiftCalendarSample
//
//  Created by osanai on 2018/10/22.
//  Copyright © 2018年 長内幸太郎. All rights reserved.
//

import Foundation

class MonthModel {
    let year:Int
    let month:Int
    let dayNum:Int
    let firstYoubi:Int  //1日の曜日 （日曜日を0とおく）
    
    var sixWeekDay:[Int] = []   // 6週間表示する際の日付（1日より前は0以下、31日よりあとは32以上で表現）
    
    init(year:Int, month:Int) {
        self.year = year
        self.month = month
        dayNum = DateUtility.dayNumOfMonth(year: year, month: month)
        firstYoubi = DateUtility.youbi(year: year, month: month, day: 1)
        
        for i in 1 ... 6*7 {
            // 例えば1日が火曜日なら、0番目は-1日、1番目は0日、2番目が1日
            sixWeekDay.append(i - firstYoubi)
        }
    }
}
