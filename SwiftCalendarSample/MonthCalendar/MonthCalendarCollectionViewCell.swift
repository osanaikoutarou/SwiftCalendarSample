//
//  MonthCalendarCollectionViewCell.swift
//  SwiftCalendarSample
//
//  Created by 長内幸太郎 on 2018/10/20.
//  Copyright © 2018年 長内幸太郎. All rights reserved.
//

import UIKit

class MonthCalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthCalendarCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        monthCalendarCollectionView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil),
                                             forCellWithReuseIdentifier: "DayCollectionViewCell")
        
        setupLayout()
    }

    func setup(monthCalendarSource:MonthCalendarSource) {
        if monthCalendarCollectionView != nil {
            monthCalendarCollectionView.delegate = monthCalendarSource
            monthCalendarCollectionView.dataSource = monthCalendarSource
            
            monthLabel.text = "\(monthCalendarSource.monthModel.year)年\(monthCalendarSource.monthModel.month)月"
        }
    }
    
    func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:monthCalendarCollectionView.bounds.width/7.0 - 5.0,
                                 height:monthCalendarCollectionView.bounds.height/7.0 - 5.0 )
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 0)
        
        monthCalendarCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
}

class MonthCalendarSource:NSObject, UICollectionViewDelegate,UICollectionViewDataSource {
    var monthModel:MonthModel!
    
    func setup(monthModel:MonthModel) {
        self.monthModel = monthModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 6週間表示する（最大）
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 曜日は7つ
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as! DayCollectionViewCell
        
        let index = indexPath.section * 7 + indexPath.item
        let cellDay = monthModel.sixWeekDay[index]
        if (cellDay <= 0 || cellDay > monthModel.dayNum) {
            cell.dayLabel.text = ""
        }
        else {
            cell.dayLabel.text = "\(cellDay)"
        }
        
        return cell
    }

}

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
