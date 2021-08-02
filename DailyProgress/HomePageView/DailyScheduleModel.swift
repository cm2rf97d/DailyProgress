//
//  DailyProgressModel.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/20.
//

import Foundation

struct DailyScheduleModel: Codable
{
    var taskItem: String = ""
    var taskContent: String = ""
    var taskDate: String = ""
    var isDone: Bool = true
}
