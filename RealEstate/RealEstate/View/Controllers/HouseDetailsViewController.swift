//
//  HouseDetailsViewController.swift
//  RealEstate
//
//  Created by Alaa Khalil on 06/01/2022.
//

import UIKit
import GoogleMaps

class HouseDetailsViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var bathroomsLabel: UILabel!
    @IBOutlet weak var bedroomsLabel: UILabel!
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var descreptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    var houseDetail: Houses?
    var distance: String?
    let locationManager = CLLocationManager()
    var houseLocation = CLLocation()
    var markerPosition : CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData()
        setMapView()
    }
    
    func setMapView(){
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        mapView.delegate = self
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        self.handlingMapView()
    }
    
    // Setting the house`s data in the view
    func setData(){
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
        DispatchQueue.main.async {
            let position = CLLocationCoordinate2D(latitude: Double((self.houseDetail?.latitude)!), longitude: Double((self.houseDetail?.longitude)!))
            let marker = GMSMarker(position: position)
            let camera = GMSCameraPosition.camera(withTarget: position, zoom: 15.0)
            self.mapView.camera = camera
            marker.title = "\(self.houseDetail?.zip ?? " ")\(self.houseDetail?.city ?? " ")"
            marker.map = self.mapView
        }
    }
    
    // back to HousesViewController
    @IBAction func dismissPressedButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}





