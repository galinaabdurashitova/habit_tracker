//
//  HabitCellView.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 12.06.2025.
//

import Foundation
import UIKit

class HabitCellView: UITableViewCell {

    private let titleLabel = UILabel()
    private let container = UIView()
    private let checkmarkImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupUI() {
        backgroundColor = .clear
        
        // Container
        container.backgroundColor = UIColor.label.withAlphaComponent(0.1)
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        
        // Label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        
        // Checkmark
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.contentMode = .scaleAspectFit
        container.addSubview(checkmarkImageView)
        
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            checkmarkImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configure(with habit: Habit, for date: Date) {
        titleLabel.text = habit.title
        let isDone = habit.isCompleted(for: date)
        checkmarkImageView.image = UIImage(systemName: isDone ? "checkmark.circle.fill" : "circle")
        checkmarkImageView.tintColor = isDone ? .systemGreen : .systemGray
    }
}
