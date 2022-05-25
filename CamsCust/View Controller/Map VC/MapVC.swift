//
//  MapVC.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 13/05/22.
//

import UIKit
import MapKit
import CoreLocation
class MapVC: UIViewController {
    
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var myMapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDetails.isHidden = true
        viewDetails.clipsToBounds = true
        viewDetails.layer.cornerRadius = 30
        viewDetails.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        getCurrentLocation()
        
    }
    func getCurrentLocation()
    {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            myMapView.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bttnCross(_ sender: Any) {
        viewDetails.isHidden = true
    }
    
}

extension MapVC: CLLocationManagerDelegate,MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("tapped on pin ")
        viewDetails.isHidden = false
        
    }
    // MARK: Location Manager Delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locationsObj = locations.last! as CLLocation
        print("Current location lat-long is = \(locationsObj.coordinate.latitude) \(locationsObj.coordinate.longitude)")
        showOnMap(location: locationsObj)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Get Location failed")
    }
    
    func showOnMap(location: CLLocation )
    {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Javed Multani"
        annotation.subtitle = "current location"
        myMapView.addAnnotation(annotation)
        myMapView.setRegion(region, animated: true)
    }
    
}
