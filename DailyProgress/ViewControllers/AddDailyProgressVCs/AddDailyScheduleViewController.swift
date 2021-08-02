//
//  AddDailyProgressViewController.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/20.
//

import UIKit

protocol addDailyScheduleDelegate
{
    func addDailySchedule(data: DailyScheduleModel)
}

class AddDailyScheduleViewController: UIViewController
{
    let viewModel = AddDailyScheduleViewModel()
    var addDailyScheduleDelegate: addDailyScheduleDelegate?
    
    let taskItemLabel: UILabel =
    {
        let label = UILabel()
        label.text = "項目："
        label.font = UIFont(name: "Helvetica-Light", size: 30)
        label.textColor = UIColor.navigationBarTintColor
        return label
    }()
    
    let taskItemTextField: UITextField =
    {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.font = UIFont(name: "Helvetica-Light", size: 25)
        textField.textAlignment = .left
        textField.placeholder = "項目"
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.navigationBarTintColor.cgColor
        textField.layer.borderWidth = 2
        textField.addTarget(self, action: #selector(textDidchange), for: .editingChanged)
        return textField
    }()
    
    let taskContentLabel: UILabel =
    {
        let label = UILabel()
        label.text = "內容："
        label.font = UIFont(name: "Helvetica-Light", size: 30)
        label.textColor = UIColor.navigationBarTintColor
        return label
    }()
    
    let taskContentTextView: UITextView =
    {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Helvetica-Light", size: 20)
        textView.textAlignment = .left
        textView.keyboardType = .default
        textView.isEditable = true
        textView.isSelectable = true
//        textView.text = "內容"
//        textView.textColor = .lightGray
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.navigationBarTintColor.cgColor
        textView.layer.borderWidth = 2
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.sizeToFit()
        textView.isScrollEnabled = false
        return textView
    }()
    
    let dateLabel: UILabel =
    {
        let label = UILabel()
        label.text = "日期："
        label.font = UIFont(name: "Helvetica-Light", size: 30)
        label.textColor = UIColor.navigationBarTintColor
        return label
    }()
    
    lazy var selectDateLabel: UILabel =
    {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy 年 MM 月 dd 日"
        label.text = dateFormatter.string(from: Date())
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 5
        label.isUserInteractionEnabled = true
        let labelTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        label.addGestureRecognizer(labelTap)
        return label
    }()
    
    lazy var datePicker: UIDatePicker =
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.date = Date()
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "zh_CN")
        picker.minimumDate = Date()
//        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return picker
    }()
    
    //MARK: Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewInit()
        setNavi()
        bindingViewModel()
    }
    
    //MARK: @objc Function
    @objc func selectDate()
    {
        let dateAlert = UIAlertController(title: "\n\n\n\n\n\n\n\n",
                                          message: "",
                                          preferredStyle: .actionSheet)
        datePicker.frame = CGRect(x: 0, y: 0, width: dateAlert.view.frame.width - 2.5 * 8, height: 200)
        let cancel = UIAlertAction(title: "取消",style: .cancel)
        let done = UIAlertAction(title: "確認", style: .default)
        { _ in
            self.viewModel.selectedDate = self.datePicker.date.dateToString()
        }
        dateAlert.view.addSubview(self.datePicker)
        dateAlert.addAction(cancel)
        dateAlert.addAction(done)
        present(dateAlert, animated: true, completion: nil)
    }
    
    @objc func addDailySchedule()
    {
        guard let taskItem = self.taskItemTextField.text,
              let taskContent = taskContentTextView.text,
              let taskDate = self.selectDateLabel.text else { return }
        viewModel.setValue(taskItem: taskItem, taskContent: taskContent, taskDate: taskDate, isDone: false)
        addDailyScheduleDelegate?.addDailySchedule(data: viewModel.dailySchedule)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissView()
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Function
    
    func bindingViewModel()
    {
        viewModel.changeDateLabelAction =
        {
            [weak self] date in
            DispatchQueue.main.async
            {
                self?.selectDateLabel.text = date
            }
        }
    }
    
    func viewInit()
    {
        //Set Delegate
        taskContentTextView.delegate = self
        
        //Set Background Color
        self.view.backgroundColor = UIColor.defaultBackgroundColor
        
        //Add Subviews
        self.view.addSubview(taskItemLabel)
        self.view.addSubview(taskItemTextField)
        self.view.addSubview(taskContentLabel)
        self.view.addSubview(taskContentTextView)
        self.view.addSubview(dateLabel)
        self.view.addSubview(selectDateLabel)
        
        //Set Layouts
        taskItemLabel.snp.makeConstraints
        { make in
            make.top.equalTo(self.view).offset(140)
            make.width.equalTo(90)
            make.left.equalTo(self.view).offset(50)
        }
        
        taskItemTextField.snp.makeConstraints
        { make in
            make.top.equalTo(taskItemLabel.snp.bottom).offset(5)
            make.left.equalTo(taskItemLabel.snp.left)
            make.right.equalTo(self.view).offset(-50)
        }
        
        taskContentLabel.snp.makeConstraints
        { make in
            make.top.equalTo(taskItemTextField.snp.bottom).offset(15)
            make.left.width.equalTo(taskItemLabel)
        }
        
        taskContentTextView.snp.makeConstraints
        { make in
            make.top.equalTo(taskContentLabel.snp.bottom).offset(5)
            make.left.equalTo(taskContentLabel.snp.left)
            make.right.equalTo(self.view).offset(-50)
        }
        
        dateLabel.snp.makeConstraints
        { make in
            make.top.equalTo(taskContentTextView.snp.bottom).offset(15)
            make.left.width.equalTo(taskItemLabel)
        }
        
        selectDateLabel.snp.makeConstraints
        { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.width.height.equalTo(taskItemTextField)
            make.left.equalTo(taskItemLabel.snp.left)
        }
    }
    
    func setNavi()
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationBarTintColor]
        self.title = "新增每日進度"
        
        //Left Button
        let sideMenuButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissView))
        sideMenuButton.tintColor = .systemBlue
        self.navigationItem.leftBarButtonItem = sideMenuButton
        
        //Right Button
        let searchButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(addDailySchedule))
        searchButton.tintColor = .systemBlue
        self.navigationItem.rightBarButtonItem = searchButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

//MARK: extemsion
extension AddDailyScheduleViewController: UITextViewDelegate
{
    func isTextEmpty()
    {
        self.navigationItem.rightBarButtonItem?.isEnabled =
            (self.taskItemTextField.text == "" || self.taskContentTextView.text == "") ? false : true
    }
    
    func textViewDidChange(_ textView: UITextView)
    {
        isTextEmpty()
    }
    
    @objc func textDidchange()
    {
        isTextEmpty()
    }
}
