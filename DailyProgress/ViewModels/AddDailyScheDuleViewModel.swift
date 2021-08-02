//
//  AddDailyScheDuleViewModel.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/22.
//

import Foundation

class AddDailyScheduleViewModel
{
    var dailySchedule: DailyScheduleModel = DailyScheduleModel()
    var changeDateLabelAction: ((String?) -> Void)?
    var selectedDate: String = ""
    {
        didSet
        {
            changeDateLabelAction?(self.selectedDate)
        }
    }
    
    func setValue(taskItem: String, taskContent: String, taskDate: String, isDone: Bool)
    {
        self.dailySchedule.taskItem = taskItem
        self.dailySchedule.taskContent = taskContent
        self.dailySchedule.taskDate = taskDate
        self.dailySchedule.isDone = isDone
    }
}
