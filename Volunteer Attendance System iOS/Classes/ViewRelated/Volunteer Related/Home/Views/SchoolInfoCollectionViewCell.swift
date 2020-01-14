//
//  SchoolInfoCollectionViewCell.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/12/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import TinyConstraints

class SchoolInfoCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    var assignedSchool: School? = nil
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "YOUR ASSIGNED SCHOOL"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = UIColor(white: 0.7, alpha: 1)
        return label
    }()
    
    private lazy var schoolName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.assignedSchool?.name
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var schoolAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.assignedSchool?.address
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var schoolPersonnel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if let schoolPersonnel = self.assignedSchool?.schoolPersonnel, self.assignedSchool?.schoolPersonnel?.count ?? 0 > 0 {
            label.text = "\(schoolPersonnel[0].firstname) \(schoolPersonnel[0].lastname)"
        } else {
            label.text = "Personnel Name: TBA"
        }
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var schoolPersonnelEmail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if let schoolPersonnel = self.assignedSchool?.schoolPersonnel, self.assignedSchool?.schoolPersonnel?.count ?? 0 > 0 {
            label.text = schoolPersonnel[0].email
        } else {
            label.text = "Personnel Email: TBA"
        }
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
    
    private let horizontalPersonnelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
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
extension SchoolInfoCollectionViewCell {
    private func setupView() {
        getSchool()
        setupStackViews()
        configureConstraints()
    }
    
    private func setupStackViews() {
        horizontalPersonnelStackView.addArrangedSubview(schoolPersonnelEmail)
        
        verticalStackView.addArrangedSubview(cellTitle)
        verticalStackView.addArrangedSubview(schoolName)
        verticalStackView.addArrangedSubview(schoolAddress)
        verticalStackView.addArrangedSubview(schoolPersonnel)
        verticalStackView.addArrangedSubview(horizontalPersonnelStackView)
        addSubview(verticalStackView)
    }
    
    private func configureConstraints() {
        verticalStackView.edgesToSuperview(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    private func getSchool() {
        let defaults = UserDefaults.standard
        guard let scheduleData = defaults.object(forKey: "currentUserSchedule") as? Data else { return }
        guard let schedule = try? PropertyListDecoder().decode(Schedule.self, from: scheduleData) else { return }
        self.assignedSchool = schedule.school
    }
    
}
