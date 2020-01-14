//
//  CheckInOutCollectionViewCell.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/8/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import TinyConstraints

class CheckInOutCollectionViewCell: BaseCollectionViewCell {

    // MARK: - Properties
    var tapCheckOut: (() -> Void)?
    
    private var counter = 0
    private var timer: Timer? = nil
    private var isPlaying = false
    
    var height: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint()
        return constraint
    }()
    
    private let timerView: TimerView = {
        let view = TimerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkOutButton: ResizableButton = {
        let button = ResizableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gciBlue
        button.setTitle("Check-Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        startTimer(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("No existing Nib")
    }
    
    // MARK: - View Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

// MARK: - View Configurations

extension CheckInOutCollectionViewCell {
    
    private func setupView() {
        setupStackView()
        configureConstraints()
        setupButtonHandlers()
    }
    
    private func setupStackView() {
        verticalStackView.addArrangedSubview(timerView)
        verticalStackView.addArrangedSubview(checkOutButton)
        addSubview(verticalStackView)
    }
    
    private func configureConstraints() {
        verticalStackView.edgesToSuperview(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        verticalStackView.setCustomSpacing(self.frame.size.height / 2, after: timerView)
        
        checkOutButton.setHugging(.required, for: .vertical)
    }
    
    @objc private func handleCheckOut(_ sender: UIButton) {
        self.tapCheckOut?()
        timer?.invalidate()
        timer = nil
        counter = 0
        self.timerView.timerLabel.text = self.updateTime(self.counter)
    }
    
    private func setupButtonHandlers() {
        checkOutButton.addTarget(self, action: #selector(handleCheckOut(_:)), for: .touchUpInside)
    }
}

// MARK: - Timer Helpers
extension CheckInOutCollectionViewCell {
    private func startTimer(_ sender: AnyObject) {
        if(isPlaying) {
            return
        }
            
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [unowned self] timer in
            self.counter = self.counter + 1
            self.timerView.timerLabel.text = self.updateTime(self.counter)
        })
        
        guard let timer = timer else { return }
        
        RunLoop.current.add(timer, forMode: .common)
        
        isPlaying = true
    }

    private func updateTime(_ time: Int) -> String {
        let seconds = time % 60
        let minutes = (time / 60) % 60
        return String(format: "%.2d:%.2d", minutes, seconds)
    }
    
    func configureLabels(_ checkedInLocation: String) {
        timerView.startedTimerLabel.text = "Started at \(getCurrentFormattedTime())"
        timerView.startedLocationLabel.text = "At \(checkedInLocation)"
    }
    
    private func getCurrentFormattedTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US_POSIX")
        format.dateFormat = "hh:mm a"
        format.amSymbol = "AM"
        format.pmSymbol = "PM"
        return format.string(from: date)
    }
}

