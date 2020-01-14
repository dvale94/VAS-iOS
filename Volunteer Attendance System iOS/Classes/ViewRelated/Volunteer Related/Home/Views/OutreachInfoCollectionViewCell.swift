//
//  OutreachInfoCollectionViewCell.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/13/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class OutreachInfoCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    private var assignedSchedule: Schedule? = nil
    private var dayOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "YOUR MEETING INFORMATION"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = UIColor(white: 0.7, alpha: 1)
        return label
    }()
    
    private let outreachLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Meet every"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var meetingDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.dayOfWeek[self.assignedSchedule?.dayofweekID ?? 0]
        label.textColor = .gciBlue
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var startingTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.assignedSchedule?.starttime
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let hypenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var endingTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.assignedSchedule?.endtime
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let horizontalMeetingDayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let horizontalMeetingTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("No existing Nib")
    }

}

// MARK: - View Configurations
extension OutreachInfoCollectionViewCell {
    private func setupView() {
        setupStackViews()
        configureConstraints()
        getSchedule()
    }
    
    private func setupStackViews() {
        horizontalMeetingDayStackView.addArrangedSubview(outreachLabel)
        horizontalMeetingDayStackView.addArrangedSubview(meetingDay)
        
        horizontalMeetingTimeStackView.addArrangedSubview(startingTime)
        horizontalMeetingTimeStackView.addArrangedSubview(hypenLabel)
        horizontalMeetingTimeStackView.addArrangedSubview(endingTime)
        
        verticalStackView.addArrangedSubview(cellTitle)
        verticalStackView.addArrangedSubview(horizontalMeetingDayStackView)
        verticalStackView.addArrangedSubview(horizontalMeetingTimeStackView)

        addSubview(verticalStackView)
    }
    
    private func configureConstraints() {
        verticalStackView.edgesToSuperview(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        horizontalMeetingTimeStackView.setCustomSpacing(10, after: startingTime)
    }
    
    private func getSchedule() {
        let defaults = UserDefaults.standard
        guard let scheduleData = defaults.object(forKey: "currentUserSchedule") as? Data else { return }
        guard let schedule = try? PropertyListDecoder().decode(Schedule.self, from: scheduleData) else { return }
        self.assignedSchedule = schedule
    }
    
}
