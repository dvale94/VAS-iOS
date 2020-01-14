//
//  TimerView.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/9/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    // MARK: - Properties
    
    let startedTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Started at \(00):\(00)"
        return label
    }()
    
    let startedLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "At W.R. Thomas Middle School"
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    let minutesLabel: UILabel = {
        let hoursLabel = UILabel()
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.text = "MIN(S)"
        hoursLabel.font = .systemFont(ofSize: 36)
        return hoursLabel
    }()
    
    private let horizontalTimerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 24
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        setupView()
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: - View Configurations

extension TimerView {
    private func setupView() {
        setupStackViews()
        configureConstraints()
    }
    
    private func setupStackViews() {
        horizontalTimerStackView.addArrangedSubview(timerLabel)
        horizontalTimerStackView.addArrangedSubview(minutesLabel)
        
        verticalStackView.addArrangedSubview(startedTimerLabel)
        verticalStackView.addArrangedSubview(startedLocationLabel)
        verticalStackView.addArrangedSubview(horizontalTimerStackView)
        addSubview(verticalStackView)
    }
    
    private func configureConstraints() {
        verticalStackView.edgesToSuperview()
    }
}
