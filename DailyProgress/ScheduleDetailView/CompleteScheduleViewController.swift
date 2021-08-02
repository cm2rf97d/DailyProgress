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
    let completeScheduleView = CompleteScheduleView()
    weak var backHomePageDelegate: BackHomePageDelegate?
    var viewModelValue: DailyScheduleModel?
    var viewModel = CompleteScheduleViewModel()
    var index: Int?
    
    //MARK: Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        bindingViewModel()
    }
    
    override func loadView()
    {
        self.view = completeScheduleView
    }
    
    init(viewModel: DailyScheduleModel, index: Int)
    {
        super.init(nibName: nil, bundle: nil)
        self.viewModelValue = viewModel
        self.index = index
        completeScheduleView.successButtonAction = completeTask
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
                self?.completeScheduleView.taskItemTextLabel.text = item
                self?.completeScheduleView.taskContentTextLabel.text = content
            }
        }
        viewModel.dailySchedule = viewModelValue
    }
    
    //MARK: Function
    func completeTask()
    {
        print("complete Task")
        viewModel.dailySchedule?.isDone = true
        if let viewModelData = viewModel.dailySchedule,
           let indexPath = self.index
        {
            print("delegaete")
            self.backHomePageDelegate?.backHomePageDelegate(viewModel: viewModelData, indexPath: indexPath)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
