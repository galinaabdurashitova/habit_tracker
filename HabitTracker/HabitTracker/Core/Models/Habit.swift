//
//  Habit.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 11.06.2025.
//

import Foundation

struct Habit {
    let id: UUID
    let title: String
    var completedDates: Set<Date>

    init(id: UUID = UUID(), title: String, completedDates: Set<Date> = []) {
        self.id = id
        self.title = title
        self.completedDates = completedDates
    }

    mutating func toggle(for date: Date) {
        let key = date.startOfDay
        if completedDates.contains(key) {
            completedDates.remove(key)
        } else {
            completedDates.insert(key)
        }
    }

    func isCompleted(for date: Date) -> Bool {
        completedDates.contains(date.startOfDay)
    }
}
