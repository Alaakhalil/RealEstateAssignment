//
//  HouseDetailsViewController.swift
//  RealEstate
//
//  Created by Alaa Khalil on 06/01/2022.
//

import UIKit
import GoogleMaps

class HouseDetailsViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
  
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var bathroomsLabel: UILabel!
    @IBOutlet weak var bedroomsLabel: UILabel!
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var descreptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    var houseDetail: Houses?
    var distance: String?
    var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var houseLocation = CLLocation()
    var markerPosition : CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
        self.setMapView()
    }
    
    func setMapView(){
        let camera = GMSCameraPosition.camera(withLatitude:  Double((self.houseDetail?.latitude)!), longitude: Double((self.houseDetail?.longitude)!), zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        map = mapView
        let marker = GMSMarker()
        let position = CLLocationCoordinate2D(latitude: Double((self.houseDetail?.latitude)!), longitude: Double((self.houseDetail?.longitude)!))
        marker.position = position
        marker.title = "\(self.houseDetail?.zip ?? " ")\(self.houseDetail?.city ?? " ")"
        marker.map = mapView
        //mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      map.addSubview(mapView)
//        mapView.delegate = self
    }
    
    // Setting the house`s data in the view
    func setData(){
    
       // self.handlingMapView()
        self.sizeLabel.text = "\(houseDetail?.size ?? 0)"
        self.bathroomsLabel.text = "\(houseDetail?.bathrooms ?? 0)"
        self.bedroomsLabel.text = "\(houseDetail?.bedrooms ?? 0)"
        self.distanceLabel.text = "\(self.distance ?? "") "
        self.descreptionTextView.text = houseDetail?.description
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0;
        self.priceLabel.text = formatter.string(from: (houseDetail?.price ?? 0) as NSNumber)
        if let value = houseDetail?.image {
            if let url = URL(string: (baseUrl + value)) {
                self.houseImage.setImageWithURL(url: url, placeHolderImage: nil)
            }
        }
        else {
            self.houseImage.image = nil
        }
        
    }
    // Show the house location and add marker for it
    func handlingMapView() {
       // DispatchQueue.main.async { [self] in
                
//            self.mapView.camera = GMSCameraPosition(target: position, zoom: 15, bearing: 0, viewingAngle: 0)
//        camera = GMSCameraPosition.camera(withLatitude: Double((self.houseDetail?.latitude)!), longitude: Double((self.houseDetail?.longitude)!), zoom: 17.0)
//        mapView.camera = camera
//        mapView.animate(to: camera)
//        let marker = GMSMarker()
//        marker.position = position
//        marker.appearAnimation = .pop
//        marker.title = "\(self.houseDetail?.zip ?? " ")\(self.houseDetail?.city ?? " ")"
//        marker.map = self.mapView
     //   }
    }
    
    // back to HousesViewController
    @IBAction func dismissPressedButton(_ sender: Any) {
        self.dismiss(animated: true)
    }


}





