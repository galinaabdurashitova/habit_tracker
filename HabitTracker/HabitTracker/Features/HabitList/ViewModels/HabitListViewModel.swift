//
//  HabitListViewModel.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation

protocol HabitListViewModelDelegate: AnyObject {
    func didUpdateHabits(_ habits: [Habit])
}

final class HabitListViewModel {
    private let storage: HabitStorageProtocol
    private(set) var habits: [Habit] = []

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
}
