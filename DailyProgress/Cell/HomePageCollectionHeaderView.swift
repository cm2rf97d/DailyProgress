//
//  HomePageCollectionHeaderView.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/26.
//

import UIKit

class HomePageCollectionHeaderView: UICollectionReusableView
{
    static let identifier = "HomePageCollectionHeaderView"
    var labelDidTap: (() -> Void)?
    
    lazy var selectDateLabel: UILabel =
    {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy 年 MM 月 dd 日"
        label.text = dateFormatter.string(from: Date())
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 18
        label.isUserInteractionEnabled = true
        let labelTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        label.addGestureRecognizer(labelTap)
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.addSubview(selectDateLabel)
        setLayouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectDate()
    {
        labelDidTap?()
    }
    
    func setLayouts()
    {
        selectDateLabel.snp.makeConstraints
        { make in
            make.top.bottom.equalTo(self).offset(-5)
            make.right.equalTo(self).offset(-10)
            make.left.equalTo(self).offset(10)
        }
    }
}
