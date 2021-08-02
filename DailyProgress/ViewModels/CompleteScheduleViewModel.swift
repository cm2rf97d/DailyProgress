//
//  CompleteScheduleViewModel.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/27.
//

import Foundation

class CompleteScheduleViewModel
{
    var reloadViewData: ((String?, String?) -> Void)?
    var dailySchedule: DailyScheduleModel?
    {
        didSet
        {
            reloadViewData?(self.dailySchedule?.taskItem, self.dailySchedule?.taskContent)
        }
    }
    
    init()
    {
        reloadViewData?(self.dailySchedule?.taskItem, self.dailySchedule?.taskContent)
    }
}
