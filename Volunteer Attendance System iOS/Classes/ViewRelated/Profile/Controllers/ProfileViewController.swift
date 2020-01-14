//
//  ViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/17/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import Eureka

class ProfileViewController: FormViewController {
    
    var currentUser: Volunteer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension ProfileViewController {
    private func setupView() {
        self.tableView.backgroundColor = UIColor(white: 0.97, alpha: 1)
        getCurrentUser()
        configureNavBar()
        setupForm()
    }
    
    private func configureNavBar() {
        title = "Profile"
    }
    
    private func getCurrentUser() {
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: "currentUser") as? Data else { return }
        guard let user = try? PropertyListDecoder().decode(Volunteer.self, from: userData) else { return }
        self.currentUser = user
    }
    
    private func setupForm() {
        form +++
            Section()
            <<< TextRow("userName").cellSetup { cell, row in
                cell.textField.placeholder = "Username"
                row.title = "Username"
                row.value = self.currentUser?.userName
            }
            <<< EmailRow("email").cellSetup { cell, row in
                cell.textField.placeholder = "Email"
                row.title = "Email"
                row.value = self.currentUser?.email
            }
            <<< TextRow("pantherNo").cellSetup { cell, row in
                cell.textField.placeholder = "Panther Number"
                row.title = "Panther Number"
                row.value = self.currentUser?.pantherNo
            }
        
        form +++
            Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Logout"
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = UIColor.systemRed
            }
            .onCellSelection { _,_ in
                let defaults = UserDefaults.standard
                defaults.set(false, forKey: "isUserLoggedIn")
                defaults.synchronize()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setRootViewController(LoginViewController(), animated: true)
            }
        
    }
}
