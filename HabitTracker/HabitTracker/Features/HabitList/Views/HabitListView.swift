//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation
import UIKit

class HabitListView: UIView {
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
    
    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    internal let weekSelectorView = WeekSelectorView()
    internal let inputViewContainer = TextFieldView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(dateLabel)
        addSubviews(headerStack, weekSelectorView, tableView, inputViewContainer)
        setupConstraints()
    }
    
    private func setupConstraints() {
        headerStack.anchor(
            top: safeAreaLayoutGuide.topAnchor, topConstant: 16,
            leading: leadingAnchor, leadingConstant: 16,
            trailing: trailingAnchor, trailingConstant: 16
        )
        
        weekSelectorView.anchor(
            top: dateLabel.bottomAnchor, topConstant: 12,
            leading: leadingAnchor, leadingConstant: 16,
            trailing: trailingAnchor, trailingConstant: 16
        )
        
        weekSelectorView.setSize(height: 44)

        tableView.anchor(
            top: weekSelectorView.bottomAnchor, topConstant: 12,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
        
        inputViewContainer.anchor(
            bottom: bottomAnchor, bottomConstant: 0,
            leading: leadingAnchor, leadingConstant: 0,
            trailing: trailingAnchor, trailingConstant: 0
        )
    }
}
