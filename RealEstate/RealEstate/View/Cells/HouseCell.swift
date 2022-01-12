//
//  HouseCell.swift
//  RealEstate
//
//  Created by Alaa Khalil on 06/01/2022.
//

import UIKit
import Kingfisher
import CoreLocation

class HouseCell: UITableViewCell {

    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var bathroomsLabel: UILabel!
    @IBOutlet weak var bedroomsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    let locationService = LocationService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // setting the house data in the house Cell
    func setData(house: Houses)-> String{
        self.sizeLabel.text = "\(house.size ?? 0)"
        self.addressLabel.text = (house.zip ?? " ") + " " + (house.city ?? " ")
        self.bathroomsLabel.text = "\(house.bathrooms ?? 0)"
        self.bedroomsLabel.text = "\(house.bedrooms ?? 0)"
        
        // setting the price of the house
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0;
        self.priceLabel.text = formatter.string(from: (house.price ?? 0) as NSNumber)

        //setting the image of house
        if let value = house.image {
            if let url = URL(string: (baseUrl + value)) {
                self.houseImage.setImageWithURL(url: url, placeHolderImage: nil)
            }
        }else {
            self.houseImage.image = nil
        }
        // check the location access and determine the distance between current location and house location
        if (locationService.status == .authorizedWhenInUse) || (locationService.status == .authorizedAlways) {
            let houseCoordinate = CLLocation(latitude: Double(house.latitude ?? 0), longitude: Double(house.longitude ?? 0))
            locationService.getLocation()
            let userCurrentLocation = locationService.userLocation()
            let distance =  (userCurrentLocation.distance(from:houseCoordinate))/1000
            distanceLabel.text = String(format:"%.2f km",distance)
            return String(String(format:"%.2f km",distance))
        }
        distanceLabel.text = "-"
        return "-"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
