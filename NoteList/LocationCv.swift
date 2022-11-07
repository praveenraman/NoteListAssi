//
//  LocationCv.swift
//  NoteList
//
//  Created by Admin on 06/11/22.
//

import UIKit
import MapKit
import CoreLocation

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}

class LocationCv: UIViewController,MKMapViewDelegate{
    
    var results: NoteData!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    var user_currentLatitude: CLLocationDegrees!
    var user_currentLongitude: CLLocationDegrees!
    @IBOutlet weak var navBarHt: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarHt.constant = deviceHeights()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }
        if results != nil{
            self.loadLocationInfo(noteResult: results)
        }
    }
    
    func loadLocationInfo(noteResult: NoteData){
        let artwork = Artwork(
            title: noteResult.headLine,
            locationName: noteResult.address,
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: noteResult.latitude, longitude: noteResult.longitude))
        let initialLocation = CLLocation(latitude: noteResult.latitude, longitude: noteResult.longitude)
        mapView.centerToLocation(initialLocation)
        mapView.addAnnotation(artwork)
    }
    @IBAction func goToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LocationCv: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                print("Not determined")
            case .restricted:
                print("Restricted")
            case .denied:
                print("Denied")
            case .authorizedAlways:
                print("Authorized Always")
            case .authorizedWhenInUse:
                print("Authorized When in Use")
            @unknown default:
                print("Unknown status")
            }
        }
    }
}
private extension MKMapView {
      func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
      ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
      }
    }
extension BinaryFloatingPoint {
    var dms: (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int(self * 3600)
        let degrees = seconds / 3600
        seconds = abs(seconds % 3600)
        return (degrees, seconds / 60, seconds % 60)
    }
}
