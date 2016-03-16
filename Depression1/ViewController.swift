//
//  ViewController.swift
//  Depression1
//
//  Created by Matthew Dee on 06/02/2016.
//  Copyright © 2016 Matthew Dee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var MapView: MKMapView!

    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //location delegate methods
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location  = locations.last
        
        var center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        self.locationManager.stopUpdatingLocation()
        
    }
    
    
    
}
