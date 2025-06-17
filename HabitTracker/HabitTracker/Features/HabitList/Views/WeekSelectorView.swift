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
        didSet {
            updateDays()
        }
    }

    var onDateSelected: ((Date) -> Void)?

    private let calendar = Calendar.current
    private var currentWeekStart: Date = Date().startOfWeek

    private let stackView = UIStackView()
    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)

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
        previousButton.setTitle("<", for: .normal)
        nextButton.setTitle(">", for: .normal)
        previousButton.addTarget(self, action: #selector(goToPreviousWeek), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(goToNextWeek), for: .touchUpInside)

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let container = UIView()
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        container.addSubview(previousButton)
        container.addSubview(stackView)
        container.addSubview(nextButton)

        previousButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            previousButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            previousButton.widthAnchor.constraint(equalToConstant: 30),

            nextButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            nextButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 30),

            stackView.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

    }

    private func updateDays() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let start = currentWeekStart
        for i in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: i, to: start) else { continue }

            let button = UIButton(type: .system)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM\nE\nd"
            button.titleLabel?.numberOfLines = 3
            button.titleLabel?.textAlignment = .center
            button.setTitle(formatter.string(from: date), for: .normal)
            button.tag = i

            button.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                self.selectedDate = date
                self.onDateSelected?(date)
            }, for: .touchUpInside)

            if calendar.isDate(date, inSameDayAs: selectedDate) {
                button.setTitleColor(.systemBlue, for: .normal)
            } else {
                button.setTitleColor(.label, for: .normal)
            }

            stackView.addArrangedSubview(button)
        }
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

