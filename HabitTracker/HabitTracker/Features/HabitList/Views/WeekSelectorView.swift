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
        previousButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .black)
        previousButton.backgroundColor = .systemBackground
        previousButton.layer.cornerRadius = 15
        previousButton.layer.shadowColor = UIColor.systemGray.cgColor
        previousButton.layer.shadowOpacity = 1
        previousButton.layer.shadowOffset = .init(width: 2, height: 2)
        previousButton.layer.shadowRadius = 0
        return previousButton
    }()
    
    private let nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle(">", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .heavy)
        nextButton.backgroundColor = .systemBackground
        nextButton.layer.cornerRadius = 15
        nextButton.layer.shadowColor = UIColor.systemGray.cgColor
        nextButton.layer.shadowOpacity = 1
        nextButton.layer.shadowOffset = .init(width: 2, height: 2)
        nextButton.layer.shadowRadius = 0
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
        stackView.backgroundColor = .systemBackground
        stackView.layer.cornerRadius = 8
        stackView.layer.shadowColor = UIColor.systemGray.cgColor
        stackView.layer.shadowOpacity = 1
        stackView.layer.shadowOffset = .init(width: 2, height: 2)
        stackView.layer.shadowRadius = 0
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
    
    private func makeDateButton(for date: Date) -> DayButtonView {
        let button = DayButtonView()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.configure(for: date, selected: calendar.isDate(date, inSameDayAs: selectedDate))
        button.addTarget(self, action: #selector(dayTapped(_:)), for: .touchUpInside)
        return button
    }

    @objc private func dayTapped(_ sender: DayButtonView) {
        print("Tapped on: \(sender.representedDate?.description ?? "nil")")
        guard let date = sender.representedDate else { return }
        self.selectedDate = date
        self.onDateSelected?(date)
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

