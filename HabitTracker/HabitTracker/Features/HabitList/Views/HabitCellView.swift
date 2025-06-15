//
//  HabitCellView.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 12.06.2025.
//

import Foundation
import UIKit

class HabitCellView: UITableViewCell {

    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.label.withAlphaComponent(0.1)
        container.layer.cornerRadius = 12
        return container
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private let checkmarkImageView: UIImageView = {
        let checkmarkImageView = UIImageView()
        checkmarkImageView.contentMode = .scaleAspectFit
        return checkmarkImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(container)
        container.addSubviews(titleLabel, checkmarkImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        container.anchor(
            top: contentView.topAnchor, topConstant: 4,
            bottom: contentView.bottomAnchor, bottomConstant: 4,
            leading: contentView.leadingAnchor, leadingConstant: 16,
            trailing: contentView.trailingAnchor, trailingConstant: 16
        )
        
        titleLabel.anchor(
            top: container.topAnchor, topConstant: 16,
            bottom: container.bottomAnchor, bottomConstant: 16,
            leading: container.leadingAnchor, leadingConstant: 16
        )
        
        checkmarkImageView.anchor(
            leading: titleLabel.trailingAnchor, leadingConstant: 8,
            trailing: container.trailingAnchor, trailingConstant: 12,
            centerY: container.centerYAnchor
        )
        checkmarkImageView.setSize(width: 24, height: 24)
    }

    func configure(with habit: Habit, for date: Date) {
        titleLabel.text = habit.title
        let isDone = habit.isCompleted(for: date)
        checkmarkImageView.image = UIImage(systemName: isDone ? "checkmark.circle.fill" : "circle")
        checkmarkImageView.tintColor = isDone ? .systemGreen : .systemGray
    }
}
