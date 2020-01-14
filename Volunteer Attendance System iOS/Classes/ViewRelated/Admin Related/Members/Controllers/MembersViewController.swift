//
//  MembersViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/28/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class MembersViewController: UITableViewController {
    // MARK: - Properties
    var users = [Volunteer]()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .whiteLarge
        indicator.color = .gciBlue
        indicator.center = self.view.center
        return indicator
    }()
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

// MARK: - Table View Configurations
extension MembersViewController {
    private func configureTableView() {
        view.addSubview(loadingView)
        loadingView.startAnimating()
        view.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        NetworkManager.shared.getAllUsers { users, error in
            if let users = users {
                DispatchQueue.main.async {
                    self.users = users
                    self.loadingView.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Table View Data Source
extension MembersViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.text = users[indexPath.row].email
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - Table View Swipe and Select Actions
extension MembersViewController {
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
        }

        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UINavigationController(rootViewController: MembersDetailViewController(with: users[indexPath.row]))
        present(detailVC, animated: true, completion: nil)
    }
}

