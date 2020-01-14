//
//  AttendanceLogTableViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/17/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class AttendanceLogCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    var attendanceEntries = [Attendance]()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .whiteLarge
        indicator.color = .gciBlue
        indicator.center = self.view.center
        return indicator
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - View Configurations
extension AttendanceLogCollectionViewController {
    private func setupView() {
        configureCollectionView()
        configureNavBar()
    }
    
    private func configureCollectionView() {
        view.addSubview(loadingView)
        loadingView.startAnimating()
        
        collectionView.backgroundColor = UIColor(white: 0.97, alpha: 1)
        
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            collectionViewLayout.minimumInteritemSpacing = 20
            collectionViewLayout.minimumLineSpacing = 20
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        collectionView.registerCellClass(AttendanceCollectionViewCell.self)
        
        getAllAttendanceLogs()
        
    }
    
    private func configureNavBar() {
        title = "Attendance"
    }
    
    private func getAllAttendanceLogs() {
        NetworkManager.shared.getAllAttendanceLogs { userAttendance, error in
            if let attendance = userAttendance?.attendances {
                self.attendanceEntries = attendance
                DispatchQueue.main.async {
                    self.loadingView.stopAnimating()
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension AttendanceLogCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if attendanceEntries.count == 0 {
            collectionView.setEmptyMessage("We can't wait for your first session!")
        } else {
            collectionView.restore()
        }
        return attendanceEntries.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellClass = AttendanceCollectionViewCell.self
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClass.cellReuseIdentifier, for: indexPath) as! AttendanceCollectionViewCell
        
        cell.attendanceEntry = attendanceEntries[indexPath.row]
        cell.configureCell()
        
        return cell
    }
    
}
