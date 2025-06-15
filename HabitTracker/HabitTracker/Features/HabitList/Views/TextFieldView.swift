//
//  TextFieldView.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation
import UIKit

class TextFieldView: UIView {
    let habitTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.textPadding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        textField.placeholder = "Enter new habit"
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.borderStyle = .roundedRect
        return textField
    }()

    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.secondarySystemBackground

        addSubviews(habitTextField, addButton)

        habitTextField.anchor(
            top: topAnchor, topConstant: 8,
            bottom: bottomAnchor, bottomConstant: 40,
            leading: leadingAnchor, leadingConstant: 16
        )

        addButton.anchor(
            top: topAnchor, topConstant: 12,
            bottom: bottomAnchor, bottomConstant: 44,
            leading: habitTextField.trailingAnchor, leadingConstant: 16,
            trailing: trailingAnchor, trailingConstant: 12
        )
        
        addButton.setSize(width: 60)

        habitTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        addButton.setContentHuggingPriority(.required, for: .horizontal)
    }
}
