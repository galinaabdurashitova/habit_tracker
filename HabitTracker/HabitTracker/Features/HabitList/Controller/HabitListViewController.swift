//
//  HabitListViewController.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 10.06.2025.
//

import Foundation
import UIKit

extension HabitListViewController: HabitListViewModelDelegate {
    func didUpdateHabits(_ habits: [Habit]) {
        self.habits = habits
        tableView.reloadData()
    }
}

class HabitListViewController: UIViewController {
    internal let viewModel: HabitListViewModel

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
        tableView.dataSource = self
        tableView.delegate = self
        inputViewContainer.addButton.addTarget(
            self,
            action: #selector(addHabit),
            for: .touchUpInside
        )
        setupUI()
        viewModel.loadHabits()
    }
    
    internal var habits: [Habit] = []
    
    internal let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.register(HabitCellView.self, forCellReuseIdentifier: "HabitCell")
        return tableView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.textAlignment = .left
        label.text = "Habits"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .ultraLight)
        label.textAlignment = .right
        label.text = DateFormatter.shortStyle.string(from: Date())
        return label
    }()
    
    private let inputViewContainer = TextFieldView()
    
    @objc private func addHabit() {
        guard let title = inputViewContainer
            .habitTextField
            .text?
            .trimmingCharacters(in: .whitespacesAndNewlines),
                !title.isEmpty else {
            return
        }

        viewModel.addHabit(title: title)
        inputViewContainer.habitTextField.text = ""
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, dateLabel, tableView, inputViewContainer)
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor, topConstant: 16,
            leading: view.leadingAnchor, leadingConstant: 16,
            trailing: view.trailingAnchor, trailingConstant: 16
        )

        dateLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor, topConstant: 16,
            leading: view.leadingAnchor, leadingConstant: 16,
            trailing: view.trailingAnchor, trailingConstant: 16
        )

        tableView.anchor(
            top: dateLabel.bottomAnchor, topConstant: 16,
            bottom: view.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor
        )
        
        inputViewContainer.anchor(
            bottom: view.bottomAnchor, bottomConstant: 0,
            leading: view.leadingAnchor, leadingConstant: 0,
            trailing: view.trailingAnchor, trailingConstant: 0
        )
    }
}
