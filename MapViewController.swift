//
//  MapViewController.swift
//  compass
//
//  Created by Federico Zanetello on 23/04/2017.
//  Copyright © 2017 Kimchi Media. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,CLLocationManagerDelegate {
  var delegate: MapViewControllerDelegate!
    
    let currentlocationManager = CLLocationManager()
    var currentlocation: CLLocation?
    var detailCorrdinate: CLLocationCoordinate2D?
    
  @IBOutlet weak var mapView: MKMapView!
  
  @IBAction func cancelTap(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func resetTap(_ sender: UIBarButtonItem) {
    delegate.update(location: CLLocation(latitude: 90, longitude: 0))
    self.dismiss(animated: true, completion: nil)
  }
  
    @IBAction func WeatherGet(_ sender: Any) {
        if(currentlocation?.coordinate.latitude == 0.0 || currentlocation?.coordinate.longitude == 0.0 || currentlocation == nil || detailCorrdinate == nil)
        {
            showLocationFauseAlert()
        }
        else
        {
            let WeatherView:WeatherViewController = WeatherViewController()
            WeatherView.loaction = currentlocation
            WeatherView.lat  = (detailCorrdinate?.latitude)!
            WeatherView.lng = (detailCorrdinate?.longitude)!
            
            present(WeatherView, animated: true, completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
    mapView.showsUserLocation = true
    if #available(iOS 9, *) {
      mapView.showsScale = true
      mapView.showsCompass = true
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    getCurrentCityLoaction()
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.didTap(_:)))
    mapView.addGestureRecognizer(gestureRecognizer)
  }
    //MARK: - StartCurrentCity
    func getCurrentCityLoaction()
    {
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            currentlocationManager.requestWhenInUseAuthorization()
            return
        }
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        startLocationManager()
    }
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled",message:"Please enable location services for this app in Settings.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            currentlocationManager.delegate = self
            currentlocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            currentlocationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("here")
        
        let newLocation = locations.last!
        if currentlocation == nil || currentlocation!.horizontalAccuracy > newLocation.horizontalAccuracy   {
            print ("improving")
            
            currentlocation = newLocation
            detailCorrdinate = newLocation.coordinate
            currentlocationManager.stopUpdatingLocation()
            return
        }
    }
    
    
  
    
    func showLocationFauseAlert() {
        let alert = UIAlertController(title: "Propmt",message:"No current location found,Please check whether to run the app for location permission,Or try clicking on the weather again after clicking ‘ok’", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ action in
            
            self.currentlocationManager.delegate = self
            self.currentlocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            self.currentlocationManager.startUpdatingLocation()
            
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
  public func didTap(_ gestureRecognizer: UIGestureRecognizer) {
    let location = gestureRecognizer.location(in: mapView)
    let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
    
    delegate.update(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    self.dismiss(animated: true, completion: nil)
  }
}


