//
//  MainTabBarController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/1/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    private var adminView: Bool = false
    
    private lazy var homeBarItem: UITabBarItem = {
        let image = UIImage(named: "home")
        let homeBarItem = UITabBarItem(title: "Home", image: image, tag: 0)
        return homeBarItem
    }()
    
    private lazy var attendanceBarItem: UITabBarItem = {
        let image = UIImage(named: "attendance")
        let attendanceBarItem = UITabBarItem(title: "Attendance", image: image, tag: 1)
        return attendanceBarItem
    }()
    
    private lazy var adminBarItem: UITabBarItem = {
        let image = UIImage(named: "admin")
        let attendanceBarItem = UITabBarItem(title: "Administrator", image: image, tag: 2)
        return attendanceBarItem
    }()
    
    private lazy var profileBarItem: UITabBarItem = {
        let image = UIImage(named: "profile")
        let profileBarItem = UITabBarItem(title: "Profile", image: image, tag: 2)
        return profileBarItem
    }()
    
    init(showAdminView: Bool) {
        self.adminView = showAdminView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController(collectionViewLayout: layout))
        let attendanceViewController = UINavigationController(rootViewController: AttendanceLogCollectionViewController(collectionViewLayout: layout))
        let adminViewController = UINavigationController(rootViewController: AdminViewController())
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())

        self.tabBar.tintColor = .gciBlue

        homeViewController.tabBarItem = homeBarItem
        attendanceViewController.tabBarItem = attendanceBarItem
        adminViewController.tabBarItem = adminBarItem
        profileViewController.tabBarItem = profileBarItem
        
        if adminView {
            viewControllers = [homeViewController, attendanceViewController, adminViewController, profileViewController]
        } else {
            viewControllers = [homeViewController, attendanceViewController, profileViewController]
        }
        
    }
    
}
