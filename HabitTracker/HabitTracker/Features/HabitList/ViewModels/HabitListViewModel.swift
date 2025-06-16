//
//  HabitListViewModel.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation

final class HabitListViewModel {
    private let storage: HabitStorageProtocol
    private(set) var habits: [Habit] = []
    private var selectedDate: Date = Date()

    weak var delegate: HabitListViewModelDelegate?

    init(storage: HabitStorageProtocol) {
        self.storage = storage
    }

    func loadHabits() {
        habits = storage.fetchHabits()
        delegate?.didUpdateHabits(habits)
    }

    func addHabit(title: String) {
        let newHabit = Habit(id: UUID(), title: title)
        storage.addHabit(newHabit)
        loadHabits()
    }

    func deleteHabit(at index: Int) {
        let habit = habits[index]
        storage.deleteHabit(habit)
        loadHabits()
    }
    
    func toggleHabitCompletion(at index: Int, for date: Date) {
        let habit = habits[index]
        storage.markHabit(habit, doneAt: date)
        loadHabits()
    }
    
    func updateDate(to date: Date) {
        selectedDate = date
        delegate?.didUpdateHabits(habits) 
    }

    func toggleHabitCompletion(at index: Int, for date: Date? = nil) {
        let habit = habits[index]
        let dateToUse = date ?? selectedDate
        var updatedHabit = habit
        updatedHabit.toggle(for: dateToUse)
        storage.markHabit(habit, doneAt: dateToUse)
        loadHabits()
    }
}
