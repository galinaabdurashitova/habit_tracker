//
//  HabitListViewController.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 10.06.2025.
//

import Foundation
import UIKit

class HabitListViewController: UIViewController {
    internal let viewModel: HabitListViewModel
    internal let rootView = HabitListView()
    internal var habits: [Habit] = []

    init(viewModel: HabitListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.inputViewContainer.addButton.addTarget(
            self,
            action: #selector(addHabit),
            for: .touchUpInside
        )
        viewModel.loadHabits()
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    @objc private func addHabit() {
        guard let title = rootView.inputViewContainer
            .habitTextField
            .text?
            .trimmingCharacters(in: .whitespacesAndNewlines),
                !title.isEmpty else {
            return
        }

        viewModel.addHabit(title: title)
        rootView.inputViewContainer.habitTextField.text = ""
    }
}
