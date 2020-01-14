//
//  AttendanceCollectionViewCell.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/26/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class AttendanceCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    var attendanceEntry: Attendance? = nil
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(for: .subheadline, weight: .bold)
        return label
    }()
    
    private lazy var signInTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private lazy var signOutTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private lazy var meetingNotes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.attendanceEntry?.notes
        label.font = .preferredFont(forTextStyle: .callout)
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
extension AttendanceCollectionViewCell {
    private func setupView() {
        setupStackViews()
        configureConstraints()
    }
    
    private func setupStackViews() {
        verticalStackView.addArrangedSubview(date)
        verticalStackView.addArrangedSubview(signInTime)
        verticalStackView.addArrangedSubview(signOutTime)
        verticalStackView.addArrangedSubview(meetingNotes)
        addSubview(verticalStackView)
    }
    
    private func configureConstraints() {
        verticalStackView.edgesToSuperview(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    func configureCell() {
        date.text = formatDate(attendanceEntry?.date ?? "")
        if let signInTime = attendanceEntry?.signInTime {
            self.signInTime.text = "Sign In Time: \(signInTime)"
            self.signInTime.numberOfLines = 0
        }
        if let signOutTime = attendanceEntry?.signInTime {
            self.signOutTime.text = "Sign Out Time: \(signOutTime)"
            self.signOutTime.numberOfLines = 0
        }
        meetingNotes.text = attendanceEntry?.notes
    }
    
    private func formatDate(_ date: String) -> String {
        if let index = date.firstIndex(of: "T") {
            return String(date.prefix(upTo: index))
        } else {
            return date
        }
    }
    
    private func formatTime(_ time: String) -> String {
        if let index = time.firstIndex(of: "T") {
            return String(time.suffix(from: index))
        } else {
            return time
        }
    }
    
}
