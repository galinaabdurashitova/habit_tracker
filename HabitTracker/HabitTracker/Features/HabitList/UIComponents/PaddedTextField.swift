//
//  PaddedTextField.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation
import UIKit

class PaddedTextField: UITextField {
    var textPadding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}

