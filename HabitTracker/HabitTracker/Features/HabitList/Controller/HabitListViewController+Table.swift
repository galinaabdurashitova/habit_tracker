//
//  HabitListViewController+Table.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 12.06.2025.
//

import Foundation
import UIKit

extension HabitListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let habit = habits[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as? HabitCellView else {
            return UITableViewCell(style: .default, reuseIdentifier: "HabitCell")
        }

        cell.configure(with: habit, for: Date())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let today = Date()
        habits[indexPath.row].toggle(for: today)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
