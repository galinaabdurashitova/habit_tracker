//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation
import UIKit

class HabitListView: UIView {
    private let background: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.systemCyan.withAlphaComponent(0.2)
        return background
    }()
    
    internal let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.register(HabitCellView.self, forCellReuseIdentifier: "HabitCell")
        return tableView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.textAlignment = .left
        label.text = "Your habits for"
        return label
    }()
    
    internal let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .black)
        label.textAlignment = .right
        label.text = DateFormatter.shortStyle.string(from: Date())
        return label
    }()
    
    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        return stack
    }()
    
    internal let weekSelectorView = WeekSelectorView()
    internal let inputViewContainer = TextFieldView()
    
    internal var inputViewBottomConstraint: NSLayoutConstraint?
    
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
        addSubviews(background, headerStack, weekSelectorView, tableView, inputViewContainer)
        setupConstraints()
    }
    
    private func setupConstraints() {
        background.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
        
        background.bottomAnchor.constraint(equalTo: weekSelectorView.centerYAnchor).isActive = true

        
        weekSelectorView.anchor(
            top: safeAreaLayoutGuide.topAnchor, topConstant: 16,
            leading: leadingAnchor, leadingConstant: 16,
            trailing: trailingAnchor, trailingConstant: 16
        )
        
        weekSelectorView.setSize(height: 60)
        
        headerStack.anchor(
            top: weekSelectorView.bottomAnchor, topConstant: 16,
            leading: leadingAnchor, leadingConstant: 16,
            trailing: trailingAnchor, trailingConstant: 16
        )

        tableView.anchor(
            top: headerStack.bottomAnchor, topConstant: 8,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
        
        inputViewBottomConstraint = inputViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        inputViewBottomConstraint?.isActive = true

        inputViewContainer.anchor(
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
    }
}
