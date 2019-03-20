

import UIKit
import MapKit

class mapkitScaeneViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    var m_LocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            m_LocationManager.delegate = self
        
            m_LocationManager.desiredAccuracy = kCLLocationAccuracyBest
            mapView.delegate = self
        if(CLLocationManager.authorizationStatus()) != .authorizedWhenInUse{
            m_LocationManager.requestWhenInUseAuthorization()
        }
        mapView.showsUserLocation = true
        m_LocationManager.startUpdatingLocation()
     
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //goToCenterLocation()
        
        //get location
        let myLocation:CLLocation = locations[0] as CLLocation
        let latitude:CLLocationDegrees = myLocation.coordinate.latitude
        let longtitude:CLLocationDegrees = myLocation.coordinate .longitude
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        //get speed
        let speed = myLocation.speed * 3.6
        speedLabel.text = "\(speed) km/h"
        addAnnotation()
       
        
        
    }
    func goToCenterLocation(){
        if let locMan = m_LocationManager.location{
            let region = MKCoordinateRegionMakeWithDistance(locMan.coordinate, 200, 200)
            mapView.setRegion(region, animated: true)
        }
    }
    func addAnnotation(){
        let TreasureAnnotation1 = MKPointAnnotation()
        TreasureAnnotation1.title = "Treasure1"
        TreasureAnnotation1.coordinate = CLLocationCoordinate2D(latitude: 13.721398, longitude:100.787082)
        
        let TreasureAnnotation2 = MKPointAnnotation()
        TreasureAnnotation2.title = "Treasure2"
        TreasureAnnotation2.coordinate = CLLocationCoordinate2D(latitude: 13.718281, longitude:100.781278)
        
        let TreasureAnnotation3 = MKPointAnnotation()
        TreasureAnnotation3.title = "Treasure3"
        TreasureAnnotation3.coordinate = CLLocationCoordinate2D(latitude: 13.729829, longitude:100.775713)
        
        let DragonAnnontation1 = MKPointAnnotation()
        DragonAnnontation1.title = "Dragon1"
        DragonAnnontation1.coordinate = CLLocationCoordinate2D(latitude: 13.712943, longitude:100.789364)
        
        let DragonAnnontation2 = MKPointAnnotation()
        DragonAnnontation2.title = "Dragon2"
        DragonAnnontation2.coordinate = CLLocationCoordinate2D(latitude: 13.713110, longitude:100.780056)
        
        let DragonGreenAnnontation1 = MKPointAnnotation()
        DragonGreenAnnontation1.title = "Dragon_Green1"
        DragonGreenAnnontation1.coordinate = CLLocationCoordinate2D(latitude: 13.717613, longitude:100.777568)
        
        let DragonPurpleAnnontation1 = MKPointAnnotation()
        DragonPurpleAnnontation1.title = "Dragon_Purple1"
        DragonPurpleAnnontation1.coordinate = CLLocationCoordinate2D(latitude: 13.725301, longitude:100.781303)
        
        mapView.addAnnotation(TreasureAnnotation1)
        mapView.addAnnotation(TreasureAnnotation2)
        mapView.addAnnotation(TreasureAnnotation3)
        mapView.addAnnotation(DragonAnnontation1)
        mapView.addAnnotation(DragonAnnontation2)
        mapView.addAnnotation(DragonGreenAnnontation1)
        mapView.addAnnotation(DragonPurpleAnnontation1)
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        if let title = annotation.title, title == "Treasure1" {
            annotationView?.image = UIImage(named: "icon_treasure (1)")
        }
        else if annotation === mapView.userLocation{
            annotationView?.image = UIImage(named: "pirate (3) br (2)")
        }
        else if let title = annotation.title, title == "Treasure2" {
            annotationView?.image = UIImage(named: "icon_treasure (1)")
        }
        else if let title = annotation.title, title == "Treasure3" {
            annotationView?.image = UIImage(named: "icon_treasure (1)")
        }
        else if let title = annotation.title, title == "Dragon1" {
            annotationView?.image = UIImage(named: "Gold_Dragon")
        }
        else if let title = annotation.title, title == "Dragon2" {
            annotationView?.image = UIImage(named: "Gold_Dragon")
        }
        else if let title = annotation.title, title == "Dragon_Green1" {
            annotationView?.image = UIImage(named: "dragon_Green")
        }
        else if let title = annotation.title, title == "Dragon_Purple1" {
            annotationView?.image = UIImage(named: "dragon_purple")
        }
        
        annotationView?.canShowCallout = true
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        print("The annotation was elected: \(String(describing: view.annotation?.title)) ")
    }
   
    

}

