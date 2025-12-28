//
//  Date+Extension.swift
//  Parla
//
//  Created by Konstantin Safronov on 28.12.2025.
//

import Foundation

extension Date {
    func monthsUntil(_ date: Date = Date()) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self, to: date)
        return components.month ?? 0
    }
    
    var monthsAgo: Int {
        return self.monthsUntil()
    }
}
