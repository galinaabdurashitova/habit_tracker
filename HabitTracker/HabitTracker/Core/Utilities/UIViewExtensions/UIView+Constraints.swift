//
//  UIView+Constraints.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation
import UIKit

extension UIView {
    func anchor(
        top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0,
        bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat = 0,
        leading: NSLayoutXAxisAnchor? = nil, leadingConstant: CGFloat = 0,
        trailing: NSLayoutXAxisAnchor? = nil, trailingConstant: CGFloat = 0,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()

        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        if let leading = leading {
            constraints.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }
        if let trailing = trailing {
            constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
        }
        if let centerX = centerX {
            constraints.append(centerXAnchor.constraint(equalTo: centerX))
        }
        if let centerY = centerY {
            constraints.append(centerYAnchor.constraint(equalTo: centerY))
        }

        NSLayoutConstraint.activate(constraints)
    }
}
