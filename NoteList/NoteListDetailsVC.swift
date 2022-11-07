//
//  NoteListDetailsVC.swift
//  NoteList
//
//  Created by Admin on 06/11/22.
//

import UIKit
import MapKit
import CoreLocation

class NoteListDetailsVC: UIViewController,MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navBarHt: NSLayoutConstraint!
    @IBOutlet weak var noteImg: UIImageView!
    @IBOutlet weak var noteName: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var descHC: NSLayoutConstraint!
    @IBOutlet weak var commentCLbl: UILabel!
    @IBOutlet weak var LikeStatusLbl: UILabel!
    @IBOutlet weak var FavouriteStatusLbl: UILabel!
    @IBOutlet weak var shareLbl: UILabel!
    @IBOutlet weak var shareImg: UIImageView!
    @IBOutlet weak var faveImg: UIImageView!
    @IBOutlet weak var latAndlogLbl: UILabel!
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    var user_currentLatitude: CLLocationDegrees!
    var user_currentLongitude: CLLocationDegrees!
    var results: NoteData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarHt.constant = deviceHeights()
        self.tagCollectionView.register(UINib(nibName: "tagCVCell", bundle: nil), forCellWithReuseIdentifier: "tagCVCell")
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
            self.loadDetailInfo(noteResult: results)
        }
        self.noteName.layer.cornerRadius = 15.0
    }
    func loadDetailInfo(noteResult: NoteData){
        let artwork = Artwork(
            title: noteResult.headLine,
            locationName: noteResult.address,
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: noteResult.latitude, longitude: noteResult.longitude))
        let initialLocation = CLLocation(latitude: noteResult.latitude, longitude: noteResult.longitude)
        mapView.centerToLocation(initialLocation)
        mapView.addAnnotation(artwork)
        if results.coverPic != nil{
            let url = URL(string: results.coverPic.url)
            DispatchQueue.global().async{
                let data = try? Data(contentsOf: url!)
                if data != nil{
                DispatchQueue.main.async {
                    self.noteImg.image = UIImage(data: data!)
                }
              }
            }
        }
        self.noteName.text = "  \(results.headLine)"
        self.desc.text = results.description
        self.LikeStatusLbl.text = "\(results.count)"
        self.commentCLbl.text = "\(results.commentsCount)"
        self.FavouriteStatusLbl.text = "\(results.commentsCount)"
        self.faveImg.image = UIImage.init(named: results.favoriteStatus ? "fave":"icons8-heart-100")
        
    }
    @IBAction func goToUserProfile(_ sender: Any) {
            let newCon = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            newCon.results = self.results
            self.navigationController?.pushViewController(newCon, animated: true)
    }
    
    @IBAction func goToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:  CollectionView Delegate / DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if results.tags.count > 0{
            return results.tags.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCVCell", for: indexPath) as! tagCVCell
        cell.tagLbl.text = results.tags[indexPath.row].name
        return cell
    }
    
    @objc(collectionView:layout:insetForSectionAtIndex:)  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc(collectionView:layout:sizeForItemAtIndexPath:)  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let amenitiTextSize = results.tags[indexPath.row].name.count
        let cellWidth = ((amenitiTextSize)*7)+43
        return CGSize(width:cellWidth, height:30)
    }
    
    //MARK: - location delegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if locations.last != nil{
            let location = locations.last! as CLLocation
            user_currentLatitude = location.coordinate.latitude
            user_currentLongitude = location.coordinate.longitude
            let loca = CLLocation(latitude: user_currentLatitude, longitude: user_currentLongitude)
            self.latAndlogLbl.text = "\(loca.dms)"
        }
    }
    @IBAction func ViewMapBtnAction(_ sender: Any) {
        currentLocation = locationManager.location
        let url = "http://maps.apple.com/maps?saddr=\(user_currentLatitude ?? 0.0),\(user_currentLongitude ?? 0.0)&daddr=\(results.latitude),\(results.longitude)"
        
        guard let openurl = URL(string: url) else {
          return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(openurl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(openurl)
        }
    }
}
extension NoteListDetailsVC: CLLocationManagerDelegate {
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

extension CLLocation {
    var dms: String { latitude + " " + longitude }
    var latitude: String {
        let (degrees, minutes, seconds) = coordinate.latitude.dms
        return String(format: "%d°%d'%d\"%@", abs(degrees), minutes, seconds, degrees >= 0 ? "N" : "S")
    }
    var longitude: String {
        let (degrees, minutes, seconds) = coordinate.longitude.dms
        return String(format: "%d°%d'%d\"%@", abs(degrees), minutes, seconds, degrees >= 0 ? "E" : "W")
    }
}
