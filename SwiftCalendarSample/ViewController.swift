//
//  ViewController.swift
//  SwiftCalendarSample
//
//  Created by 長内幸太郎 on 2018/10/20.
//  Copyright © 2018年 長内幸太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calendarCollectionView: UICollectionView!
    // 1月分のUICollectionViewDelegateとUICollectionViewDatasource
    // ViewControllerで持つ
    var monthCalendarSources:[MonthCalendarSource] = []
    // 表示する月
    let displayMonths:[(year:Int, month:Int)] = [(2018,1),(2018,2),(2018,3),(2018,4),(2018,5),(2018,6),
                                                 (2018,7),(2018,8),(2018,9),(2018,10),(2018,11),(2018,12),
                                                 (2019,1),(2019,2),(2019,3),(2019,4),(2019,5),(2019,6),
                                                 (2019,7),(2019,8),(2019,9),(2019,10),(2019,11),(2019,12)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        setupCollectionView()
        
        setupLayout()
    }
    
    func setupData() {
        displayMonths.forEach { (yearMonth) in
            let monthCalendarSource = MonthCalendarSource()
            monthCalendarSource.monthModel = MonthModel(year: yearMonth.year, month: yearMonth.month)
            monthCalendarSources.append(monthCalendarSource)
        }
    }
    
    func setupCollectionView() {
        // calendarCollectionViewの中で、MonthCalendarCollectionViewCellを使う
        // 使う際には、"MonthCalendarCollectionViewCell"の識別子で使う
        calendarCollectionView.register(UINib(nibName: "MonthCalendarCollectionViewCell", bundle: nil),
                                        forCellWithReuseIdentifier: "MonthCalendarCollectionViewCell")

        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
    }
    
    func setupLayout() {
        // 横向き
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = calendarCollectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        calendarCollectionView.isPagingEnabled = true
        calendarCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayMonths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCalendarCollectionViewCell", for: indexPath) as! MonthCalendarCollectionViewCell
        cell.setup(monthCalendarSource: monthCalendarSources[indexPath.item])
        return cell
    }
}

