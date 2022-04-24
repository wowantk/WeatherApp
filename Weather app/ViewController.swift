//
//  ViewController.swift
//  Weather app
//
//  Created by macbook on 29.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temretureLabel: UILabel!
    @IBOutlet weak var loadingFlag: UIActivityIndicatorView!
    
    private let cuurentPositionManager: CurrentPositionManager = PositionManagerImpl()
    private let locationManager  = LocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingFlag.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(handleLocationUpdate), name: .locationPost, object: nil)
        setUpLocationManager()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateView(object: WeatherObject?) {
        guard let object = object else {
            return
        }
        cityLabel.text = object.location
        descriptionLabel.text = object.description
        temretureLabel.text = String(object.temp.rounded()) + " C°"
    }
    
    private func setUpLocationManager() {
        locationManager.checkLocationService()
        LocationManager.makeAlertView = { [weak self] name, second in
            let alert = UIAlertController(title: name, message: second, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
   
    @objc private func handleLocationUpdate() {
        cuurentPositionManager.findCurrentPlace(lan: locationManager.getLatitude(), lot: locationManager.getLongitude()) { [weak self] object in
            self?.updateView(object: object)
        }
    }
    
    
}

