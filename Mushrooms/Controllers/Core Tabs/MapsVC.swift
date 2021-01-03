//
//  MapsVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit
import MapKit
import CoreLocation

class MapsVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    private var mushrooms: Posts?
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        
        view.addSubview(mapView)
        
        mapView.delegate = self
        locationManager.delegate = self
        

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMushrooms()
        startLocation()
    }
  
    private func customNavBar() {
        //Navigation bar setup
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",
                                                                                                            size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255,
                                                                                                                        green: 59/255,
                                                                                                                        blue: 59/255,
                                                                                                                        alpha: 1.0)]
    }
    
    private func startLocation() {
        //start get user location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func fetchMushrooms() {
        //get mushrooms
        DatabaseManager.shared.fetchMushrooms(completion: {[weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                print(error)
            case .success(let mushrooms):
                strongSelf.anotationMap(mushrooms: mushrooms)
            }
        })
    }
    
    
    //MARK:- Map funcs
    
    private func anotationMap(mushrooms: Posts) {
        //add anotation in mushrooms location
        guard let mushrooms = mushrooms.post else {return}
        for mushroom in mushrooms {
            guard let lat = mushroom.lat, let long = mushroom.long, let name = mushroom.name else {return}
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
            let anotation = MKPointAnnotation()
            anotation.coordinate = location
            anotation.title = name
            self.mapView.addAnnotation(anotation)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //custom anotation and add navigation button in anotation
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView?.canShowCallout = true
            pinView?.tintColor = .systemPink
            
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
            
        }else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //navigation func
        
        guard let lat = view.annotation?.coordinate.latitude,
              let long = view.annotation?.coordinate.longitude,
              let name = view.annotation?.title else {return}
        
        let mushroomLocation = CLLocation(latitude: lat, longitude: long)
        
        CLGeocoder().reverseGeocodeLocation(mushroomLocation, completionHandler: {placaMarks, error in
            if !placaMarks!.isEmpty {
                let newPlaceMark = MKPlacemark(placemark: (placaMarks?.first)!)
                let item = MKMapItem(placemark: newPlaceMark)
                item.name = name
                let launchOptions = [
                    MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
                ]
                item.openInMaps(launchOptions: launchOptions)
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //show location in map
        if let coordinate = locations.first {
            let location = CLLocationCoordinate2D(latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
        }
    }
}
