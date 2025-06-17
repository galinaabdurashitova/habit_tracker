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
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let dotView: UIView = {
        let dot = UIView()
        dot.backgroundColor = .systemBlue
        dot.layer.cornerRadius = 3
        dot.isHidden = true
        return dot
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM\nE\nd"
        return formatter
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
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
        addSubview(stack)
        stack.addSubviews(titleLabel, dotView)
//        stack.addArrangedSubview(titleLabel)
//        stack.addArrangedSubview(dotView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stack.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
        
        titleLabel.anchor(
            top: stack.topAnchor
        )
        
        dotView.anchor(
            top: titleLabel.bottomAnchor, topConstant: 4,
            bottom: stack.bottomAnchor,
            centerX: titleLabel.centerXAnchor
        )
        
        dotView.setSize(width: 6, height: 6)
    }
    
    func configure(for date: Date, selected: Bool) {
        self.representedDate = date
        titleLabel.text = dateFormatter.string(from: date)
        isSelected = selected
        updateStyle()
    }
    
    private func updateStyle() {
        titleLabel.textColor = isSelected ? .systemBlue : .label
        dotView.isHidden = !calendar.isDateInToday(representedDate ?? Date())
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
