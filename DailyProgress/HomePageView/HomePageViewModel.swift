//
//  HomePageViewModel.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/21.
//

import Foundation
import UIKit

protocol HomePageViewModelObserver
{
    func homePageViewDataDidUpdate(_ scheduleValue: HomePageViewModel)
}

class HomePageViewModel
{
    static let shared = HomePageViewModel()
    
    var observers: [HomePageViewModelObserver] = []
    
    //MARK: Models
    
    init()
    {
        loadData()
    }
    
    var selectedDate: String = Date().dateToString()
    {
        didSet
        {
            saveData()
            observers.forEach({$0.homePageViewDataDidUpdate(self)})
        }
    }
    
    private var undoneDailySchedule: [String: [DailyScheduleModel]] = [:]
    {
        didSet
        {
            saveData()
            observers.forEach({$0.homePageViewDataDidUpdate(self)})
        }
    }
    
    private var doneDailySchedule: [String: [DailyScheduleModel]] = [:]
    {
        didSet
        {
            saveData()
            observers.forEach({$0.homePageViewDataDidUpdate(self)})
        }
    }
    
    func addObserver(_ observer: HomePageViewModelObserver)
    {
        observers.append(observer)
    }
    
    func getSchedule(viewType: ViewType) -> [DailyScheduleModel]
    {
        switch viewType
        {
        case .undone:
            return undoneDailySchedule[self.selectedDate] ?? []
        case .done:
            return doneDailySchedule[self.selectedDate] ?? []
        }
    }
    
    func setSchedule(type: ViewType, value: DailyScheduleModel)
    {
        switch type
        {
            case .undone:
                if var tempData = undoneDailySchedule[value.taskDate]
                {
                    tempData.append(value)
                    undoneDailySchedule.updateValue(tempData, forKey: value.taskDate)
                }
                else
                {
                    undoneDailySchedule[value.taskDate] = [value]
                }
            case .done:
                if var tempData = doneDailySchedule[value.taskDate]
                {
                    tempData.append(value)
                    doneDailySchedule.updateValue(tempData, forKey: value.taskDate)
                }
                else
                {
                    doneDailySchedule[value.taskDate] = [value]
                }
        }
    }
    
    func removeUndoneScheduleData(indexPath: Int)
    {
        var undoneScheduleData = self.getSchedule(viewType: .undone)
        undoneScheduleData.remove(at: indexPath)
        self.undoneDailySchedule.updateValue(undoneScheduleData, forKey: self.selectedDate)
    }
    
    func saveData()
    {
        let undonedata = try? PropertyListEncoder().encode(undoneDailySchedule)
        let donedata = try? PropertyListEncoder().encode(doneDailySchedule)
        UserDefaults.standard.setValue(undonedata, forKey: UserdefaultKey.undoneScheduleInfo)
        UserDefaults.standard.setValue(donedata, forKey: UserdefaultKey.doneScheduleInfo)
        UserDefaults.standard.setValue(self.selectedDate, forKey: UserdefaultKey.scheduleDate)
    }

    func loadData()
    {
        if let undoneData = UserDefaults.standard.value(forKey: UserdefaultKey.undoneScheduleInfo) as? Data,
           let doneData = UserDefaults.standard.value(forKey: UserdefaultKey.doneScheduleInfo) as? Data,
           let date = UserDefaults.standard.string(forKey: UserdefaultKey.scheduleDate)
        {
            do
            {
                let undoneInfo = try PropertyListDecoder().decode([String:[DailyScheduleModel]].self, from: undoneData)
                let doneInfo = try PropertyListDecoder().decode([String:[DailyScheduleModel]].self, from: doneData)
                self.undoneDailySchedule = undoneInfo
                self.doneDailySchedule = doneInfo
                self.selectedDate = date
            }
            catch
            {
                print(error)
            }
        }
    }
}

private extension HomePageViewModel
{
    enum UserdefaultKey
    {
        static let undoneScheduleInfo = "undoneScheduleInfo"
        static let doneScheduleInfo = "doneScheduleInfo"
        static let scheduleDate = "scheduleDate"
    }
}
