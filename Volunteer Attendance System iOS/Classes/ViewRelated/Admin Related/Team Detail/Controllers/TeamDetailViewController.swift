//
//  TeamDetailViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/26/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import Eureka

class TeamDetailViewController: FormViewController {
    
    private lazy var addTeam: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Add Team"
        barButtonItem.target = self
        barButtonItem.action = #selector(addTeam(_:))
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
    
    var team: Team?
    
    init(with team: Team? = nil) {
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.team = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension TeamDetailViewController {
    private func setupView() {
        configureNavBar()
        setupForm()
    }
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        title = "Details"
        self.navigationItem.rightBarButtonItem = self.team == nil ? addTeam : saveChanges
    }
    
    @objc private func addTeam(_ sender: UIBarButtonItem) {
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
        addTeam.isEnabled = form.validate().isEmpty
        saveChanges.isEnabled = checkForChanges()
    }
    
    private func checkForChanges() -> Bool {
        return (form.rowBy(tag: "teamnumber") as? IntRow)?.wasChanged ?? false  || (form.rowBy(tag: "teamdescription") as? TextAreaRow)?.wasChanged ?? false || (form.rowBy(tag: "volunteer") as? MultipleSelectorRow<String>)?.wasChanged ?? false
    }
    
    private func setupForm() {
        form +++
            Section("Team Information")
            <<< IntRow("teamnumber").cellSetup { cell, row in
                cell.textField.placeholder = "Team Number"
                row.title = "Team Number"
                row.value = Int(self.team?.teamnumber ?? "")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
            <<< TextAreaRow("teamdescription") { row in
                row.placeholder = "Description"
                row.textAreaHeight = .dynamic(initialTextViewHeight: 50)
                row.value = self.team?.teamDescription
                row.validationOptions = .validatesOnChange
                row.onChange { [weak self] (row) in
                    self?.validateRows()
                }
            }
        form +++
        Section("Team Volunteers")
        <<< MultipleSelectorRow<String>("volunteer") {
            $0.title = "Volunteers"
            $0.optionsProvider = .lazy({ (form, completion) in
                let activityView = UIActivityIndicatorView(style: .gray)
                form.tableView.backgroundView = activityView
                activityView.startAnimating()
                let session = URLSession.shared
                let url = URL(string: "http://commandsapiname.azurewebsites.net/api/UserProfile/all")!
                let task = session.dataTask(with: url) { data, response, error in
                    do {
                        let users = try JSONDecoder().decode([Volunteer].self, from: data!)
                        DispatchQueue.main.async {
                            form.tableView.backgroundView = nil
                            completion(users.map { $0.pantherNo! } )
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                task.resume()
            })
            $0.validationOptions = .validatesOnChange
            $0.onChange { [weak self] (row) in
                self?.validateRows()
            }
        }
        .onPresent { from, to in
            to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(TeamDetailViewController.multipleSelectorDone(_:)))
        }
        form +++
            Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Delete Team"
                row.disabled = Condition.function(["Delete Team?"], { form -> Bool in
                    return self.team == nil
                })
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = row.isDisabled ? UIColor.lightGray : UIColor.systemRed
            }
    }
    
    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}

