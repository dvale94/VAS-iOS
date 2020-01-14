//
//  AdminViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/24/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class AdminViewController: TabmanViewController {
    // MARK: - Properties
    private var viewControllers = [SchoolsViewController(), MembersViewController()]
    private var barItemTitles = ["Schools", "Members"]
    
    let database = NetworkManager()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.isScrollEnabled = false
    }
}

// MARK: - View Configurations
extension AdminViewController {
    private func setupView() {
        view.backgroundColor = UIColor(white: 0.97, alpha: 1)
        configureButtonBar()
        configureNavBar()
    }
    
    private func configureButtonBar() {
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.tintColor = .gciBlue
        bar.indicator.tintColor = .gciBlue
        bar.layout.contentMode = .fit
        addBar(bar, dataSource: self, at: .top)
    }
    
    private func configureNavBar() {
        title = "Admin Dashboard"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntity(_:)))
    }
    
}

extension AdminViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: barItemTitles[index])
    }
    

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
}

// MARK: - Add School or Member
extension AdminViewController {
    @objc private func addEntity(_ sender: UIBarButtonItem) {
        if currentIndex == 0 {
            let addSchoolVC = UINavigationController(rootViewController: SchoolDetailViewController())
            self.present(addSchoolVC, animated: true, completion: nil)
        } else {
            let addUserVC = UINavigationController(rootViewController: MembersDetailViewController())
            self.present(addUserVC, animated: true, completion: nil)
        }
    }
}
