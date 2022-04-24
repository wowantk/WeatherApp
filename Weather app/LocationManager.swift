//
//  LocationManager.swift
//

import Foundation
import CoreLocation

extension Notification.Name {
    static let locationPost = Notification.Name(rawValue: "LocationPost")
}

final class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    public static var makeAlertView: ((String,  String) -> Void)!
    
    override init() {
        super.init()
    }
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
            setUpLocationManager()
        } else {
            LocationManager.makeAlertView("Location Off", "Please on location")
        }
    }
    
    
    private func setUpLocationManager() {
        locationManager.delegate = self
    }
    
}

extension LocationManager {
   
    func getLongitude() -> Double {
        if let long = locationManager.location?.coordinate.longitude{
            return long
        } else {
            return 0
        }
    }
    
    func getLatitude() -> Double {
        if let lattid = locationManager.location?.coordinate.latitude{
            return lattid
        } else {
            return 0
        }
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            NotificationCenter.default.post(name: .locationPost, object: nil, userInfo: nil)
            locationManager.startUpdatingLocation()
            break
        case .denied:
            LocationManager.makeAlertView("Location is Off", "Please on Location to show current Wheather")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            LocationManager.makeAlertView("Location is Off", "Please on Location to show current Wheather")
            break
        case .authorizedAlways:
            break
        default: break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
