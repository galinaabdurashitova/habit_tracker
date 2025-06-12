//
//  HabitListViewController.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 10.06.2025.
//

import Foundation
import UIKit

class HabitListViewController: UIViewController {
    internal let tableView = UITableView()
    internal var habits: [Habit] = [
        Habit(id: UUID(), title: "Drink water"),
        Habit(id: UUID(), title: "Walk 30 minutes"),
        Habit(id: UUID(), title: "Read 10 pages")
    ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .ultraLight)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        title = "Habits"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        view.addSubview(titleLabel)
        titleLabel.text = "Habits"
        
        view.addSubview(dateLabel)
        dateLabel.text = formatter.string(from: Date())
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HabitCellView.self, forCellReuseIdentifier: "HabitCell")
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
