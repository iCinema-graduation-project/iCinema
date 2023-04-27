//
//  LocationManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/04/2023.
//

import UIKit
import CoreLocation


@available(iOS 14.0, *)
open class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    public static let shared = LocationManager()
    
    public private(set) var latitude: CLLocationDegrees!
    public private(set) var longitude: CLLocationDegrees!
    
    public override init() {
        super.init()
        delegate = self
        requestWhenInUseAuthorization()
        startUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            print("location updated")
        }
    }
    
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .denied {
            showLocationDisabledPopUp()
        }
    }
    
    /// Show the popup to the user if we have been denied access
    private func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: NSLocalizedString("title", bundle: .module, comment: ""),
                                                message: NSLocalizedString("message", bundle: .module, comment: ""),
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", bundle: .module, comment: ""), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: NSLocalizedString("open", bundle: .module, comment: ""), style: .default) { [self] (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true)
        
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    }
    
    
    
}
