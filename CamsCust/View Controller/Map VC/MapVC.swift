//  MapVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 13/05/22.
import UIKit
import MapKit
import CoreLocation
import CoreMedia
class MapVC: UIViewController {
    
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var myMapView: MKMapView!
    
    
    //DETAIL VIEW OUTLETS
    @IBOutlet var detailATMName: UILabel!
    @IBOutlet var detailATMID: UILabel!
    @IBOutlet var detailATMDesc: UILabel!
    @IBOutlet var detailATMAddress: UILabel!
    @IBOutlet var detailATMImage: UIImageView!
    var selectedPinLat:Double = 0.0
    var selectedPinLng:Double = 0.0
    var selectedPinName:String = ""
    
        
    var locationManager: CLLocationManager!
    
    
    var assetList:[MapsPinsData]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDetails.isHidden = true
        viewDetails.clipsToBounds = true
        viewDetails.layer.cornerRadius = 30
        viewDetails.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        self.getMapPinDetails()
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
    
    
    func reloadMap() {
        showAssetsOnMap()
    }
    
    
    @IBAction func detailDirectionsAction(_ sender: Any) {
        
        if selectedPinLat != 0.0 && selectedPinLng != 0.0 {
            let url = URL(string: "maps://?q=Title&ll=\(selectedPinLat),\(selectedPinLng)")!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        
    }
    
    
    
    
}

extension MapVC: CLLocationManagerDelegate,MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("tapped on pin ")
        let annotation = view.annotation as? SSCustPointAnnotation
        print("\(annotation?.selectedAtmIndex ?? -111)")
        
        let index = annotation?.selectedAtmIndex ?? -1
        if self.assetList != nil && index != -1 {
            let pin = self.assetList?[index]
            
            detailATMName.text = pin?.aTMDescription
            detailATMID.text = "\(pin?.aTMID ?? 0)"
            detailATMDesc.text = "\(pin?.postalCode ?? "")"
            
            let address = "\(pin?.address1 ?? "")\n\(pin?.city ?? "") \(pin?.stateCode ?? "")\n\(pin?.postalCode ?? "")"
            detailATMAddress.text = address
            
            if (pin?.aTMPhoto != nil && pin?.aTMPhoto != "") {
                detailATMImage.sd_setImage(with: URL(string: pin?.aTMPhoto ?? ""))
            }
            
            
            let lat = Double(pin?.latitude ?? "0.0") ?? 0.0
            let lng = Double(pin?.longitude ?? "0.0") ?? 0.0
            selectedPinLat = lat
            selectedPinLng = lng
            
            selectedPinName = pin?.aTMDescription ?? ""
            
            viewDetails.isHidden = false
        }
        
        
        
        
        
        
        
        
    }
    // MARK: Location Manager Delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locationsObj = locations.last! as CLLocation
        print("Current location lat-long is = \(locationsObj.coordinate.latitude) \(locationsObj.coordinate.longitude)")
//        showOnMap(location: locationsObj)
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
    
    
    
    
    func showAssetsOnMap()
    {
        if assetList != nil && assetList?.count ?? 0 > 0 {
            for i in 0...(self.assetList?.count ?? 1)-1 {
                
                let pin = self.assetList?[i]
                
                let lat = Double(pin?.latitude ?? "0.0") ?? 0.0
                let lng = Double(pin?.longitude ?? "0.0") ?? 0.0
                let title = pin?.aTMDescription
                let address = "\(pin?.address1 ?? "") \(pin?.city ?? "") \(pin?.stateCode ?? "")"
                
                let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                let annotation = SSCustPointAnnotation(customVariable: i)
                annotation.coordinate = center
                annotation.title = title
                annotation.subtitle = address
                myMapView.addAnnotation(annotation)
                myMapView.setRegion(region, animated: true)
                
            }
        }
    }
    
    
    
    
}
