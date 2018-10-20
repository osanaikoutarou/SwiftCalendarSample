//
//  DateUtility.swift
//  SwiftCalendarSample
//
//  Created by 長内幸太郎 on 2018/10/21.
//  Copyright © 2018年 長内幸太郎. All rights reserved.
//

import UIKit

class DateUtility: NSObject {

    static func youbi(year:Int, month:Int, day:Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date) - 1 // 0 - 6
    }
    
    static func dayNumOfMonth(year:Int, month:Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        return numDays
    }
    
    static func d() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        
        components.year = 2018
        components.month = 11
        
        let newDate = calendar.date(from: components)
        
        return newDate!
    }
}
