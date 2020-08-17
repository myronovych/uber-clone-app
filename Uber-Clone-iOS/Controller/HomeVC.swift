//
//  HomeVC.swift
//  Uber-Clone-iOS
//
//  Created by rs on 14.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    let inputIndicatorView = LocationInputIndicationView()
    let locationInputView = LocationInputView()
    
    let tableView = UITableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIsUserLogged()
        locationStatus()
        configureTableView()
        fetchUserData()
    }
    
    func fetchUserData() {
        Service.shared.fetchUserData() { user in
            print("USER DATA: \(user)")
        }
    }
    
    private func checkIsUserLogged() {
        if let user = Auth.auth().currentUser {
            print("Current user: " + user.uid)
            configureUI()
        } else {
            print("User not logged in")
            let destVC = UINavigationController(rootViewController: LoginVC())
            destVC.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(destVC, animated: true)
            }
        }
    }
    
    private func signOutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error occured while sign out \(error)")
        }
    }
    
    func configureUI() {
        configureMapView()
        configureInputIndicatorView()
        
    }
    
    private func configureInputIndicatorView() {
        view.addSubview(inputIndicatorView)
        inputIndicatorView.delegate = self
        inputIndicatorView.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, left: view.safeAreaLayoutGuide.leftAnchor, topPadding: 42, rightPadding: 32, leftPadding: 32, height: 50)
        
        inputIndicatorView.alpha = 0
        UIView.animate(withDuration: 2) {
            self.inputIndicatorView.alpha = 1
        }
    }
    
    private func configureLocationInputView() {
        view.addSubview(locationInputView)
        locationInputView.delegate = self
        locationInputView.anchor(top: view.topAnchor, right: view.rightAnchor, left: view.leftAnchor, height: 200)
        
        locationInputView.alpha = 0
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1
            self.tableView.frame.origin.y = 200
        }) { _ in
            print("Debug: list is coming")
        }
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.bounds
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DestinationTableViewCell.self, forCellReuseIdentifier: DestinationTableViewCell.reuseId)
        tableView.rowHeight = 50
        
        let height = view.frame.height - locationInputView.frame.height
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height)
        
        view.addSubview(tableView)
    }
}

extension HomeVC: CLLocationManagerDelegate {
    
    func locationStatus() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print(CLLocationManager.authorizationStatus())
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("when in use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}


extension HomeVC: LocationInputIndicationViewDelegate {
    func presentLocationInputView() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.inputIndicatorView.alpha = 0
        }) { _ in
            self.configureLocationInputView()
        }
    }
}

extension HomeVC: LocationInpuViewDelegate {
    @objc func hideInputView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        }) { _ in
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3, animations: {
                self.inputIndicatorView.alpha = 1
            })
        }
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DestinationTableViewCell.reuseId) as! DestinationTableViewCell
        
        return cell
    }
    
    
}
