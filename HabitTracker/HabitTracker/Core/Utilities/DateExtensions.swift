//
//  DateExtensions.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 12.06.2025.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var asString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
}
