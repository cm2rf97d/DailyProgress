//
//  CompleteScheduleViewController.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/27.
//

import UIKit

protocol BackHomePageDelegate: AnyObject
{
    func backHomePageDelegate(viewModel: DailyScheduleModel, indexPath: Int)

}
class CompleteScheduleViewController: UIViewController
{
    //MARK: - Properties
    weak var backHomePageDelegate: BackHomePageDelegate?
    var viewModelValue: DailyScheduleModel?
    var viewModel = CompleteScheduleViewModel()
    var index: Int?
    
    //MARK: - IBOutlets
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
    
    //MARK: Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        bindingViewModel()
        viewInit()
    }
    
    init(viewModel: DailyScheduleModel, index: Int)
    {
        super.init(nibName: nil, bundle: nil)
        self.viewModelValue = viewModel
        self.index = index
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindingViewModel()
    {
        viewModel.reloadViewData =
        {
            [weak self] item, content in
            DispatchQueue.main.async
            {
                self?.taskItemTextLabel.text = item
                self?.taskContentTextLabel.text = content
            }
        }
        viewModel.dailySchedule = viewModelValue
    }
    
    //MARK: Function
    @objc func completeTask()
    {
        viewModel.dailySchedule?.isDone = true
        if let viewModelData = viewModel.dailySchedule,
           let indexPath = self.index
        {
            self.backHomePageDelegate?.backHomePageDelegate(viewModel: viewModelData, indexPath: indexPath)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: ViewInt
    func viewInit()
    {
        //Set Background Color
        self.view.backgroundColor = UIColor.defaultBackgroundColor
        
        //Set SubViews
        self.view.addSubview(successButton)
        self.view.addSubview(delayButton)
        self.view.addSubview(taskItemLabel)
        self.view.addSubview(taskItemTextLabel)
        self.view.addSubview(taskContentLabel)
        self.view.addSubview(taskContentTextLabel)
        
        //Set Layouts
        successButton.snp.makeConstraints
        { make in
            make.top.equalTo(self.view).offset(50)
            make.centerX.equalTo(self.view).offset(100)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        delayButton.snp.makeConstraints
        { make in
            make.top.width.height.equalTo(successButton)
            make.centerX.equalTo(self.view).offset(-100)
        }
        
        taskItemLabel.snp.makeConstraints
        { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(delayButton.snp.bottom).offset(70)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
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
            make.left.equalTo(self.view).offset(50)
            make.right.equalTo(-50)
            make.centerX.equalTo(taskItemLabel)
        }
    }
}
