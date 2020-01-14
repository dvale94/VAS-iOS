//
//  MembersDetailViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/25/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import Eureka

class MembersDetailViewController: FormViewController {
    
    private lazy var addUser: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Add User"
        barButtonItem.target = self
        barButtonItem.action = #selector(addUser(_:))
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
    
    var user: Volunteer?
    
    init(with user: Volunteer? = nil) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.user = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

extension MembersDetailViewController {
    private func setupView() {
        configureNavBar()
        setupForm()
    }
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        title = "Details"
        self.navigationItem.rightBarButtonItem = self.user == nil ? addUser : saveChanges
    }
    
    @objc private func addUser(_ sender: UIBarButtonItem) {
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
        addUser.isEnabled = form.validate().isEmpty
        saveChanges.isEnabled = checkForChanges()
    }
    
    private func checkForChanges() -> Bool {
        return (form.rowBy(tag: "username") as? TextRow)?.wasChanged ?? false  ||
               (form.rowBy(tag: "email") as? EmailRow)?.wasChanged ?? false ||
               (form.rowBy(tag: "pantherNo") as? IntRow)?.wasChanged ?? false ||
               (form.rowBy(tag: "firstname") as? TextRow)?.wasChanged ?? false ||
               (form.rowBy(tag: "lastname") as? TextRow)?.wasChanged ?? false ||
               (form.rowBy(tag: "position") as? TextRow)?.wasChanged ?? false ||
               (form.rowBy(tag: "major") as? TextRow)?.wasChanged ?? false ||
               (form.rowBy(tag: "caravailable") as? SegmentedRow<String>)?.wasChanged ?? false ||
               (form.rowBy(tag: "currentstatus") as? TextRow)?.wasChanged ?? false ||
               (form.rowBy(tag: "mdcpsid") as? IntRow)?.wasChanged ?? false
    }
    
    private func setupForm() {
        form +++
            Section("User Information")
            <<< TextRow("userName").cellSetup { cell, row in
                cell.textField.placeholder = "Username"
                row.title = "Username"
                row.value = self.user?.userName
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< EmailRow("email") { row in
                row.title = "EmailRow"
                row.value = self.user?.email
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< IntRow("pantherNo").cellSetup { cell, row in
                cell.textField.placeholder = "Panther Number"
                row.title = "Panther Number"
                row.value = Int(self.user?.pantherNo ?? "")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextRow("firstname").cellSetup { cell, row in
                cell.textField.placeholder = "First Name"
                row.title = "First Name"
                row.value = self.user?.firstname
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextRow("lastname").cellSetup { cell, row in
                cell.textField.placeholder = "Last Name"
                row.title = "Last Name"
                row.value = self.user?.lastname
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextRow("position").cellSetup { cell, row in
                cell.textField.placeholder = "Position"
                row.title = "Position"
                row.value = self.user?.position
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextRow("major").cellSetup { cell, row in
                cell.textField.placeholder = "Major"
                row.title = "Major"
                row.value = self.user?.major
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< SegmentedRow<String>(){ row in
                row.title = "Car Available?"
                row.options = ["Yes", "No"]
                row.value = "No"
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextRow("currentstatus").cellSetup { cell, row in
                cell.textField.placeholder = "Current Status"
                row.title = "Current Status"
                row.value = self.user?.currentstatus
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< IntRow("mdcpsid").cellSetup { cell, row in
                cell.textField.placeholder = "MDCPS ID"
                row.title = "MDCPS ID"
                row.value = self.user?.mdcpsid
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
        form +++
            Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Delete User"
                row.disabled = Condition.function(["Delete User?"], { form -> Bool in
                    return self.user == nil
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
