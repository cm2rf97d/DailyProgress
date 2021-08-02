//
//  DefaultColor.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/20.
//

import Foundation
import UIKit

extension UIColor
{
    static let defaultBackgroundColor = UIColor.white
    static let tabBarButtonColor = UIColor(red: 54/255, green: 65/255, blue: 65/255, alpha: 1)
    static let navigationBarTintColor = UIColor(red: 43/255, green: 182/255, blue: 86/255, alpha: 1)
    
    static func cycleBackgroundColor() -> UIColor
    {
        return UIColor(red: 117/255, green: 221/255, blue: 102/255, alpha: 1)
    }
}
