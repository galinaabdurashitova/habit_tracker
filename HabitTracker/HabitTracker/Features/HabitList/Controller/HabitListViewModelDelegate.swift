//
//  HabitListViewModelDelegate.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation


protocol HabitListViewModelDelegate: AnyObject {
    func didUpdateHabits(_ habits: [Habit])
}

extension HabitListViewController: HabitListViewModelDelegate {
    func didUpdateHabits(_ habits: [Habit]) {
        self.habits = habits
        rootView.tableView.reloadData()
    }
}
