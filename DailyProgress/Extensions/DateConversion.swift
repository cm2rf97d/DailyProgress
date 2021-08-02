//
//  DateConversion.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/27.
//

import Foundation
import UIKit

extension UIViewController
{
    @objc func dateChanged(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy 年 MM 月 dd 日"
        return dateFormatter.string(from: date)
    }
}

extension Date
{
    func dateToString(format: String = "yyyy 年 MM 月 dd 日") -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self) 
    }
}
