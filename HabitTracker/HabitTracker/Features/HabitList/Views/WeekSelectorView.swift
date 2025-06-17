//
//  WeekSelectorView.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 16.06.2025.
//

import Foundation
import UIKit

class WeekSelectorView: UIView {
    var selectedDate: Date = Date() {
        didSet { updateDays() }
    }

    var onDateSelected: ((Date) -> Void)?

    private let calendar = Calendar.current
    private var currentWeekStart: Date = Date().startOfWeek
    
    private let previousButton: UIButton = {
        let previousButton = UIButton(type: .system)
        previousButton.setTitle("<", for: .normal)
        return previousButton
    }()
    
    private let nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle(">", for: .normal)
        return nextButton
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM\nE\nd"
        return formatter
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return stackView
    }()
    
    private let container = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        updateDays()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        updateDays()
    }

    private func setupUI() {
        container.addSubviews(previousButton, stackView, nextButton)
        addSubview(container)
        
        setupConstraints()
        
        previousButton.addTarget(self, action: #selector(goToPreviousWeek), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(goToNextWeek), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        container.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
        
        previousButton.anchor(
            leading: container.leadingAnchor,
            centerY: container.centerYAnchor
        )
            
        previousButton.setSize(width: 30)
        
        nextButton.anchor(
            trailing: container.trailingAnchor,
            centerY: container.centerYAnchor
        )
            
        nextButton.setSize(width: 30)
        
        stackView.anchor(
            top: container.topAnchor,
            bottom: container.bottomAnchor,
            leading: previousButton.trailingAnchor, leadingConstant: 8,
            trailing: nextButton.leadingAnchor, trailingConstant: 8
        )
    }

    private func updateDays() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let start = currentWeekStart
        for i in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: i, to: start) else { continue }
            let button = makeDateButton(for: date)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func makeDateButton(for date: Date) -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.numberOfLines = 3
        button.titleLabel?.textAlignment = .center
        button.setTitle(dateFormatter.string(from: date), for: .normal)
//        button.tag = i

        button.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            self.selectedDate = date
            self.onDateSelected?(date)
        }, for: .touchUpInside)

        button.setTitleColor(
               calendar.isDate(date, inSameDayAs: selectedDate) ? .systemBlue : .label,
               for: .normal
           )
        
        return button
    }

    @objc private func goToPreviousWeek() {
        guard let previous = calendar.date(byAdding: .day, value: -7, to: currentWeekStart) else { return }
        currentWeekStart = previous
        updateDays()
    }

    @objc private func goToNextWeek() {
        guard let next = calendar.date(byAdding: .day, value: 7, to: currentWeekStart) else { return }
        currentWeekStart = next
        updateDays()
    }
}

