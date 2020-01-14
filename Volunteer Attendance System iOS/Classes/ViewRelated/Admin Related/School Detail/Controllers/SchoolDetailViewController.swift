//
//  SchoolDetailViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/26/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import Eureka

class SchoolDetailViewController: FormViewController {
    
    private lazy var addSchool: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Add School"
        barButtonItem.target = self
        barButtonItem.action = #selector(addSchool(_:))
        barButtonItem.isEnabled = false
        return barButtonItem
    }()
    
    private lazy var saveChanges: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Save Changes"
        barButtonItem.target = self
        barButtonItem.action = #selector(saveChanges(_:))
        barButtonItem.isEnabled = false
        return barButtonItem
    }()
    
    var school: School?
    
    init(with school: School? = nil) {
        self.school = school
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.school = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

extension SchoolDetailViewController {
    private func setupView() {
        configureNavBar()
        setupForm()
    }
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        title = "Details"
        self.navigationItem.rightBarButtonItem = self.school == nil ? addSchool : saveChanges
    }
    
    @objc private func addSchool(_ sender: UIBarButtonItem) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        let activityButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(activityButton, animated: true)
        
        navigationItem.hidesBackButton = true
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
    }
    
    @objc private func saveChanges(_ sender: UIBarButtonItem) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        let activityButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(activityButton, animated: true)
        
        navigationItem.hidesBackButton = true
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
    }
    
    private func validateRows() {
        addSchool.isEnabled = form.validate().isEmpty
        saveChanges.isEnabled = checkForChanges()
    }
    
    private func checkForChanges() -> Bool {
        return (form.rowBy(tag: "schoolid") as? IntRow)?.wasChanged ?? false  ||
            (form.rowBy(tag: "name") as? TextRow)?.wasChanged ?? false ||
            (form.rowBy(tag: "address") as? TextRow)?.wasChanged ?? false ||
            (form.rowBy(tag: "grade") as? TextRow)?.wasChanged ?? false ||
            (form.rowBy(tag: "phonenumber") as? PhoneRow)?.wasChanged ?? false ||
            (form.rowBy(tag: "dayofweekId") as? SegmentedRow<String>)?.wasChanged ?? false ||
            (form.rowBy(tag: "starttime") as? TimeRow)?.wasChanged ?? false ||
            (form.rowBy(tag: "endtime") as? TimeRow)?.wasChanged ?? false ||
            (form.rowBy(tag: "classize") as? IntRow)?.wasChanged ?? false
    }
    
    private func setupForm() {
        form +++
            Section("School Information")
            <<< IntRow("schoolid").cellSetup { cell, row in
                cell.textField.placeholder = "School ID"
                row.title = "ID"
                row.value = Int(self.school?.schoolid ?? "")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextRow("name").cellSetup { cell, row in
                cell.textField.placeholder = "School Name"
                row.title = "Name"
                row.value = self.school?.name
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextRow("address").cellSetup { cell, row in
                cell.textField.placeholder = "School Address"
                row.title = "Address"
                row.value = self.school?.address
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextRow("grade").cellSetup { cell, row in
                cell.textField.placeholder = "School Grade(s)"
                row.title = "Grades"
                row.value = self.school?.grade
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< PhoneRow("phonenumber").cellSetup { cell, row in
                cell.textField.placeholder = "Phone Number"
                row.title = "Phone"
                row.value = self.school?.phonenumber
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
        }
        
        form +++
            Section("School Schedule")
            <<< SegmentedRow<String>("dayofweekId"){ row in
                row.title = "Meets?"
                row.options = ["M", "T", "W", "TH", "F"]
                row.value = "M"
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            
            <<< TimeRow("starttime"){ row in
                row.title = "Start Time"
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TimeRow("endtime"){ row in
                row.title = "End Time"
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< IntRow("classize").cellSetup { cell, row in
                cell.textField.placeholder = "10"
                row.title = "Class Size"
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
        
        let teamSection = Section("Team(s)")
        form +++
        teamSection
        school?.teams?.forEach { team in
            teamSection <<< ButtonRow() { row in
                row.title = "Team \(team.teamnumber)"
            }
            .cellUpdate { cell, row in
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.textColor = .black
            }
            .onCellSelection { cell, row in
                self.navigationController?.pushViewController(TeamDetailViewController(with: team), animated: true)
            }
        }
        teamSection
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Add Team"
            }
            .onCellSelection { [weak self] (cell, row) in
                self?.navigationController?.pushViewController(TeamDetailViewController(), animated: true)
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textAlignment = .left
        }
        
        form +++
            Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Delete School"
                row.disabled = Condition.function(["Delete Team?"], { form -> Bool in
                    return self.school == nil
                })
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = row.isDisabled ? UIColor.systemGray : UIColor.systemRed
        }
    }
    
    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}
