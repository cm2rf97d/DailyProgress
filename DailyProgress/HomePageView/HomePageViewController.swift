//
//  HomePageViewController.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/20.
//

import UIKit
import SnapKit

class HomePageViewController: UIViewController
{
    let homePageView = HomePageView()
    var viewType: ViewType
    var schedules: [DailyScheduleModel] = []
    var date: String?
    
    init(viewType: ViewType)
    {
        self.viewType = viewType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initView()
        HomePageViewModel.shared.addObserver(self)
        HomePageViewModel.shared.loadData()
    }
    
    override func loadView()
    {
        self.view = homePageView
    }
    
    //MARK: Init View
    func initView()
    {
        homePageView.myCollectionView.delegate = self
        homePageView.myCollectionView.dataSource = self
    }
    
    func selectDate()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        datepicker.date = Date()
        datepicker.preferredDatePickerStyle = .wheels
        datepicker.locale = Locale(identifier: "zh_CN")

        let dateAlert = UIAlertController(title: "\n\n\n\n\n\n\n\n",
                                            message: "",
                                            preferredStyle: .actionSheet)
        datepicker.frame = CGRect(x: 0, y: 0, width: dateAlert.view.frame.width - 2.5 * 8, height: 200)
        let cancel = UIAlertAction(title: "取消",style: .cancel)
        let done = UIAlertAction(title: "確認", style: .default)
        { _ in
            HomePageViewModel.shared.selectedDate = datepicker.date.dateToString()
        }
        dateAlert.view.addSubview(datepicker)
        dateAlert.addAction(cancel)
        dateAlert.addAction(done)
        self.present(dateAlert, animated: true, completion: nil)
    }
}

extension HomePageViewController: addDailyScheduleDelegate
{
    func addDailySchedule(data: DailyScheduleModel)
    {
        HomePageViewModel.shared.setSchedule(type: .undone, value: data)
    }
}

extension HomePageViewController: BackHomePageDelegate
{
    func backHomePageDelegate(viewModel: DailyScheduleModel, indexPath: Int)
    {
        print("sdf")
        HomePageViewModel.shared.setSchedule(type: .done, value: viewModel)
        HomePageViewModel.shared.removeUndoneScheduleData(indexPath: indexPath)
    }
}

extension HomePageViewController: HomePageViewModelObserver
{
    func dateDidUpdate()
    {
        homePageView.myCollectionView.reloadData()
    }
    
    func homePageViewDataDidUpdate(_ scheduleValue: HomePageViewModel)
    {
        self.schedules = scheduleValue.getSchedule(viewType: self.viewType)
        homePageView.myCollectionView.reloadData()
    }
}

//MARK: - CollectionView
extension HomePageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.schedules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        let schedule = schedules[indexPath.row]
        
        cell.itemLabel.text = schedule.taskItem
        cell.contentLabel.text = schedule.taskContent
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let vc = CompleteScheduleViewController(viewModel: self.schedules[indexPath.row],
                                                index: indexPath.row)
        vc.backHomePageDelegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        switch kind
        {
            case UICollectionView.elementKindSectionHeader:
                
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomePageCollectionHeaderView.identifier, for: indexPath) as? HomePageCollectionHeaderView else {return UICollectionReusableView()}
                headerView.labelDidTap = selectDate
                headerView.selectDateLabel.text = HomePageViewModel.shared.selectedDate
                return headerView
                
            default:
                return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

enum ViewType
{
    case undone,done
}
