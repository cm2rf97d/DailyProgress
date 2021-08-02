//
//  HomeCollectionViewCell.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/20.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell
{
    static let identifier = "HomeCollectionViewCell"
    
    let itemTitleLabel: UILabel =
    {
        let label = UILabel()
        label.text = "項目："
        label.font = UIFont(name: "DINAlternate-Bold", size: 20)
        label.textColor = UIColor.defaultBackgroundColor
        return label
    }()
    
    let itemLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "DINAlternate-Bold", size: 16)
        label.textColor = UIColor.tabBarButtonColor
        return label
    }()
    
    let contentTitleLabel: UILabel =
    {
        let label = UILabel()
        label.text = "實際內容："
        label.font = UIFont(name: "DINAlternate-Bold", size: 20)
        label.textColor = UIColor.defaultBackgroundColor
        return label
    }()
    
    let contentLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "DINAlternate-Bold", size: 15)
        label.textColor = UIColor.tabBarButtonColor
        label.numberOfLines = 6
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.navigationBarTintColor
        setSubViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Views
    func setSubViews()
    {
        contentView.addSubview(itemTitleLabel)
        contentView.addSubview(itemLabel)
        contentView.addSubview(contentTitleLabel)
        contentView.addSubview(contentLabel)
    }
    
    //MARK: - Set Layouts
    func setLayouts()
    {
        itemTitleLabel.snp.makeConstraints
        { make in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-160)
        }
        
        itemLabel.snp.makeConstraints
        { make in
            make.top.equalTo(itemTitleLabel.snp.bottom).offset(1)
            make.left.right.equalTo(itemTitleLabel)
        }
        
        contentTitleLabel.snp.makeConstraints
        { make in
            make.top.equalTo(itemLabel.snp.bottom).offset(5)
            make.left.right.equalTo(itemTitleLabel)
        }
        
        contentLabel.snp.makeConstraints
        { make in
            make.top.equalTo(contentTitleLabel.snp.bottom).offset(3)
            make.left.right.equalTo(itemTitleLabel)
//            make.bottom.equalTo(self).offset(-5)
        }
    }
}
