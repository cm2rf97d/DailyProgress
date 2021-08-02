//
//  CompleteScheduleView.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/8/2.
//

import UIKit

class CompleteScheduleView: UIView
{
    var successButtonAction: (() -> Void)?
    
    let successButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("完成", for: .normal)
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 1
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(completeTask), for: .touchUpInside)
        return button
    }()
    
    let delayButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("順延至...", for: .normal)
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 1
        button.backgroundColor = .systemRed
        return button
    }()
    
    let taskItemLabel: UILabel =
    {
        let label = UILabel()
        label.text = "項目"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Light", size: 30)
        label.textColor = UIColor.navigationBarTintColor
        return label
    }()
    
    let taskItemTextLabel: UILabel =
    {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "Helvetica-Light", size: 25)
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        return label
    }()
    
    let taskContentLabel: UILabel =
    {
        let label = UILabel()
        label.text = "內容"
        label.font = UIFont(name: "Helvetica-Light", size: 30)
        label.textColor = UIColor.navigationBarTintColor
        label.textAlignment = .center
        return label
    }()
    
    let taskContentTextLabel: UILabel =
    {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "Helvetica-Light", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
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
    
    @objc func completeTask()
    {
        successButtonAction?()
    }
    
    func setViews()
    {
        self.addSubview(successButton)
        self.addSubview(delayButton)
        self.addSubview(taskItemLabel)
        self.addSubview(taskItemTextLabel)
        self.addSubview(taskContentLabel)
        self.addSubview(taskContentTextLabel)
    }
    
    func setLayouts()
    {
        successButton.snp.makeConstraints
        { make in
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self).offset(100)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        delayButton.snp.makeConstraints
        { make in
            make.top.width.height.equalTo(successButton)
            make.centerX.equalTo(self).offset(-100)
        }
        
        taskItemLabel.snp.makeConstraints
        { make in
            make.centerX.equalTo(self)
            make.top.equalTo(delayButton.snp.bottom).offset(70)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        
        taskItemTextLabel.snp.makeConstraints
        { make in
            make.top.equalTo(taskItemLabel.snp.bottom).offset(15)
            make.centerX.left.right.equalTo(taskItemLabel)
        }
        
        taskContentLabel.snp.makeConstraints
        { make in
            make.top.equalTo(taskItemTextLabel.snp.bottom).offset(40)
            make.left.right.centerX.equalTo(taskItemLabel)
        }
        
        taskContentTextLabel.snp.makeConstraints
        { make in
            make.top.equalTo(taskContentLabel.snp.bottom).offset(20)
            make.left.equalTo(self).offset(50)
            make.right.equalTo(-50)
            make.centerX.equalTo(taskItemLabel)
        }
    }
}
