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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        viewModel.loadHabits()
        
        rootView.weekSelectorView.onDateSelected = { [weak self] date in
            self?.viewModel.updateDate(to: date)
            self?.rootView.dateLabel.text = DateFormatter.shortStyle.string(from: date)
        }
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
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }

        rootView.inputViewBottomConstraint?.constant = -keyboardFrame.height + view.safeAreaInsets.bottom

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        rootView.inputViewBottomConstraint?.constant = 0

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

}
