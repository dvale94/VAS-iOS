//
//  HomeViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/1/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: BaseCollectionViewController {
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    private var schedule: Schedule? = nil
    private var currentAttendanceEntryId: String?  = nil
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

// MARK: - View Configurations
extension HomeViewController {
    private func configureCellTypes() {
        cellTypes = [.schoolInfo, .meetingsInfo]
    }
    
    private func setupView() {
        getUserSchedule()
        configureCollectionView()
        configureNavBar()
    }
    
    private func getUserSchedule() {
        let defaults = UserDefaults.standard
        
        guard let userData = defaults.object(forKey: "currentUser") as? Data else { return }
        guard let user = try? PropertyListDecoder().decode(Volunteer.self, from: userData) else { return }
        
        NetworkManager.shared.getScheduleForUser(with: user.email ?? "") { schedule, error in
            if let schedule = schedule {
                self.schedule = schedule
                print(schedule.starttime)
                let defaults = UserDefaults.standard
                defaults.set(try? PropertyListEncoder().encode(schedule), forKey: "currentUserSchedule")
                defaults.synchronize()
                DispatchQueue.main.async {
                    self.configureCellTypes()
                    self.configureCollectionView()
                    self.configureNavBar()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    private func configureCollectionView() {
        
        collectionView.backgroundColor = UIColor(white: 0.97, alpha: 1)
        
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            collectionViewLayout.minimumInteritemSpacing = 20
            collectionViewLayout.minimumLineSpacing = 20
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        for type in cellTypes {
            collectionView.registerCellClass(type.getClass)
        }
        
    }
    
    private func configureNavBar() {
        title = "Dashboard"
        self.navigationItem.rightBarButtonItem = cellTypes.count > 0 ? UIBarButtonItem(title: "Check In", style: .plain, target: self, action: #selector(showCheckIn(_:))) : nil
    }
    
    @objc private func showCheckIn(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Are you ready to check in?", message: nil, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            NetworkManager.shared.signIn { attendanceId, error in
                if let id = attendanceId {
                    self.currentAttendanceEntryId = id
                    DispatchQueue.main.async {
                        self.navigationItem.rightBarButtonItem?.isEnabled.toggle()
                        self.handleTimerCell()
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    private func handleTimerCell() {
        if (self.collectionView.numberOfItems(inSection: 0) > 0 ) {
            self.collectionView.performBatchUpdates({
                self.cellTypes.insert(.timer, at: 0)
                self.collectionView.registerCellClass(HomeCollectionViewCellType.timer.getClass)
                self.collectionView.insertItems(at: [IndexPath.init(row: 0, section: 0)])
                self.collectionView.reloadData()
            }, completion: nil)
            
            let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0))
             
            if let c = cell as? CheckInOutCollectionViewCell {
                if let schoolName = self.schedule?.school?.name {
                    c.configureLabels(schoolName)
                }
                c.tapCheckOut = {
                    self.handleCheckOut()
                }
            }
        } else {
            self.collectionView.reloadData()
        }
    }
    
    private func handleCheckOut() {
        if let inSession = currentAttendanceEntryId {
            NetworkManager.shared.signOut(for: inSession) { wasSuccessful, error in
                if wasSuccessful == true {
                    self.currentAttendanceEntryId = nil
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.collectionView.numberOfItems(inSection: 0)
                        self.collectionView.performBatchUpdates({
                            self.navigationItem.rightBarButtonItem?.isEnabled.toggle()
                            self.cellTypes.remove(at: 0)
                            self.collectionView.deleteItems(at: [IndexPath.init(row: 0, section: 0)])
                        }, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "An error occured when checking out.", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
//        let feedbackViewController = UINavigationController(rootViewController: CheckOutFeedbackViewController())
//        if #available(iOS 13.0, *) {
//            feedbackViewController.isModalInPresentation = true
//        }
//        present(feedbackViewController, animated: true, completion: nil)
    }
    
    
}

// MARK: - Location Manager
extension HomeViewController: CLLocationManagerDelegate {
    @objc private func checkUserLocation(_ sender: UIBarButtonItem) {
        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            self.navigationItem.rightBarButtonItem?.isEnabled.toggle()
            self.handleTimerCell()
            break
        }

        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            print("Current location: \(currentLocation)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
