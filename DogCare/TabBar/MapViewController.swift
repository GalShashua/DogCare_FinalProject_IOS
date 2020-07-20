//
//  MapViewController.swift
//  DogCare
//
//  Created by user167535 on 6/15/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: IBOutlets

    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Map Update

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest //
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    // MARK: add locations
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin1 = MKPointAnnotation()
        pin1.coordinate = CLLocationCoordinate2D(latitude: 31.929930, longitude: 34.832008)
        pin1.title = "Jack's Place"
        pin1.subtitle = "0523117166"
        
        let pin2 = MKPointAnnotation()
        pin2.coordinate = CLLocationCoordinate2D(latitude: 31.899421, longitude: 34.808513)
        pin2.title = "Miran Doggies"
        pin2.subtitle = "0526773548"
        
        let pin3 = MKPointAnnotation()
        pin3.coordinate = CLLocationCoordinate2D(latitude: 32.161663, longitude: 34.848846)
        pin3.title = "Michael Veterinarian"
        pin3.subtitle = "039664785"
        
        let pin4 = MKPointAnnotation()
        pin4.coordinate = CLLocationCoordinate2D(latitude: 32.089556, longitude: 34.969777)
        pin4.title = "Jimmie choo"
        pin4.subtitle = "0526653876"
        
        let pin5 = MKPointAnnotation()
        pin5.coordinate = CLLocationCoordinate2D(latitude: 32.070938, longitude: 34.817851)
        pin5.title = "Sariel Veterinarian"
        pin5.subtitle = "0524243548"
        
        let pin6 = MKPointAnnotation()
        pin6.coordinate = CLLocationCoordinate2D(latitude: 32.049407, longitude: 34.758073)
        pin6.title = "Dogs hospital"
        pin6.subtitle = "038765437"
        
        let pin7 = MKPointAnnotation()
        pin7.coordinate = CLLocationCoordinate2D(latitude: 32.326597, longitude: 34.887337)
        pin7.title = "dogimi"
        pin7.subtitle = "0526611148"
        
        let pin8 = MKPointAnnotation()
        pin8.coordinate = CLLocationCoordinate2D(latitude: 32.230228, longitude: 34.971164)
        pin8.title = "Doogigo"
        pin8.subtitle = "0526773548"
        
        let pin9 = MKPointAnnotation()
        pin9.coordinate = CLLocationCoordinate2D(latitude: 32.429818, longitude: 34.923067)
        pin9.title = "Keraso's Place"
        pin9.subtitle = "0508646531"
        
        let pin10 = MKPointAnnotation()
        pin10.coordinate = CLLocationCoordinate2D(latitude: 32.486597, longitude: 35.103088)
        pin10.title = "Muli Care"
        pin10.subtitle = "0526153548"
        
        let pin11 = MKPointAnnotation()
        pin11.coordinate = CLLocationCoordinate2D(latitude: 32.758407, longitude: 35.043997)
        pin11.title = "Health Care Dog Center"
        pin11.subtitle = "097656555"
        
        let pin12 = MKPointAnnotation()
        pin12.coordinate = CLLocationCoordinate2D(latitude: 32.910721, longitude: 35.273396)
        pin12.title = "Shir Veterinarian"
        pin12.subtitle = "048362563"
        
        let pin13 = MKPointAnnotation()
        pin13.coordinate = CLLocationCoordinate2D(latitude: 32.962586, longitude: 35.493091)
        pin13.title = "Kimchi Doggies"
        pin13.subtitle = "079532464"
        
        let pin14 = MKPointAnnotation()
        pin14.coordinate = CLLocationCoordinate2D(latitude: 32.486597, longitude: 35.103088)
        pin14.title = "Doggie"
        pin14.subtitle = "0526712345"
        
        let pin15 = MKPointAnnotation()
        pin15.coordinate = CLLocationCoordinate2D(latitude: 32.600048, longitude: 35.302348)
        pin15.title = "Dog CenterPark"
        pin15.subtitle = "0576113548"
        
        let pin16 = MKPointAnnotation()
        pin16.coordinate = CLLocationCoordinate2D(latitude: 31.955658, longitude: 34.801865)
        pin16.title = "Nuit Veterinarian"
        pin16.subtitle = "0526448736"
        
        let pin17 = MKPointAnnotation()
        pin17.coordinate = CLLocationCoordinate2D(latitude: 32.076757, longitude: 34.889814)
        pin17.title = "Dogs Love"
        pin17.subtitle = "059876543"
        
        let pin18 = MKPointAnnotation()
        pin18.coordinate = CLLocationCoordinate2D(latitude: 32.486597, longitude: 35.103088)
        pin18.title = "Dog garden"
        pin18.subtitle = "0526708418"
        
        let pin19 = MKPointAnnotation()
        pin19.coordinate = CLLocationCoordinate2D(latitude: 31.793555, longitude: 34.650006)
        pin19.title = "Kiko"
        pin19.subtitle = "0535885373"
        
        let pin20 = MKPointAnnotation()
        pin20.coordinate = CLLocationCoordinate2D(latitude: 31.184609, longitude: 34.759943)
        pin20.title = "Asher Veterinarian"
        pin20.subtitle = "0526773548"
        
        let pin21 = MKPointAnnotation()
        pin21.coordinate = CLLocationCoordinate2D(latitude: 32.027871, longitude: 34.774197)
        pin21.title = "Puppies & Doggies"
        pin21.subtitle = "0526773548"
        
        
        mapView.addAnnotation(pin1)
        mapView.addAnnotation(pin2)
        mapView.addAnnotation(pin3)
        mapView.addAnnotation(pin4)
        mapView.addAnnotation(pin5)
        mapView.addAnnotation(pin6)
        mapView.addAnnotation(pin7)
        mapView.addAnnotation(pin8)
        mapView.addAnnotation(pin9)
        mapView.addAnnotation(pin10)
        mapView.addAnnotation(pin11)
        mapView.addAnnotation(pin12)
        mapView.addAnnotation(pin13)
        mapView.addAnnotation(pin14)
        mapView.addAnnotation(pin15)
        mapView.addAnnotation(pin16)
        mapView.addAnnotation(pin17)
        mapView.addAnnotation(pin18)
        mapView.addAnnotation(pin19)
        mapView.addAnnotation(pin20)
        mapView.addAnnotation(pin21)
    }
}
