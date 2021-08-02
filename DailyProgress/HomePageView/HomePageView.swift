//
//  HomePageView.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/31.
//

import UIKit

class HomePageView: UIView
{
    lazy var myCollectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 190)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(HomePageCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomePageCollectionHeaderView.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
//    lazy var datePicker: UIDatePicker =
//    {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//
//        let picker = UIDatePicker()
//        picker.datePickerMode = .date
//        picker.date = Date()
//        picker.preferredDatePickerStyle = .wheels
//        picker.locale = Locale(identifier: "zh_CN")
//        return picker
//    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.defaultBackgroundColor
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews()
    {
        self.addSubview(myCollectionView)
    }
    
    func setLayouts()
    {
        myCollectionView.snp.makeConstraints
        { make in
            make.edges.equalTo(self)
        }
    }
}
