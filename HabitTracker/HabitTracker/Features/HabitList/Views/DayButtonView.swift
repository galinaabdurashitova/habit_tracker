//
//  DayButtonView.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 17.06.2025.
//

import Foundation
import UIKit

class DayButtonView: UIControl {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let dotView: UIView = {
        let dot = UIView()
        dot.backgroundColor = .white
        dot.layer.cornerRadius = 3
        dot.layer.opacity = 0
        return dot
    }()
    
    private let monthAndWeekDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM\nE"
        return formatter
    }()
    
    private let dayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 0
        return stack
    }()
    
    internal var representedDate: Date?
    private let calendar = Calendar.current
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .systemBlue
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(stack)
//        stack.addSubviews(titleLabel, dateLabel, dotView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(dotView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stack.anchor(
            top: topAnchor, topConstant: 4,
            bottom: bottomAnchor, bottomConstant: 4,
            leading: leadingAnchor, leadingConstant: 2,
            trailing: trailingAnchor, trailingConstant: 2,
            centerX: centerXAnchor
        )
        
        dotView.setSize(width: 6, height: 6)
    }
    
    func configure(for date: Date, selected: Bool) {
        self.representedDate = date
        titleLabel.text = monthAndWeekDateFormatter.string(from: date)
        dateLabel.text = dayDateFormatter.string(from: date)
        isSelected = selected
        updateStyle()
    }
    
    private func updateStyle() {
        titleLabel.textColor = isSelected ? .white : .label
        dateLabel.textColor = isSelected ? .white : .label
        backgroundColor =  isSelected ? .systemBlue : .clear
        dotView.backgroundColor = isSelected ? .white : .systemBlue
        dotView.layer.opacity = !calendar.isDateInToday(representedDate ?? Date()) ? 0 : 1
    }
    
    override var isSelected: Bool {
        didSet { updateStyle() }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch ended")
        sendActions(for: .touchUpInside)
        super.touchesEnded(touches, with: event)
    }
}
