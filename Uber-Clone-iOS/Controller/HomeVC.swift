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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIsUserLogged()
        locationStatus()
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
        
        view.addSubview(inputIndicatorView)
        inputIndicatorView.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, left: view.safeAreaLayoutGuide.leftAnchor, topPadding: 42, rightPadding: 32, leftPadding: 32, height: 50)
        
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.bounds
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
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
