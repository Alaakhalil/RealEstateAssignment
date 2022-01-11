//
//  HousesViewController.swift
//  RealEstate
//
//  Created by Alaa Khalil on 06/01/2022.
//

import UIKit
import CoreLocation



class HousesViewController: UIViewController, CLLocationManagerDelegate{
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var housesTableView: UITableView!
    var searching = false
    var noDataView = UIView()
    var distances = [String:String]()
    var userCoordinate:CLLocation?
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        handleNoResults()
        noDataView.isHidden = true
        adjustmentSearchBar()
        getData()
        enableLocation()
    }
    
    func enableLocation(){
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }

    
    // Handling the Houses and reloaded in the tableView
    func getData(){
        HousesViewModel.instance.fetchHouses { status in
            switch status {
            case .success: self.housesTableView.reloadData()
            case .failure: print("Failed to fetch the Data")
            }
        }
    }
    
    // Customize searchBar to match the design
    func adjustmentSearchBar(){
        self.searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        let searchTextField:UITextField = searchBar.value(forKey: "searchField") as? UITextField ?? UITextField()
        searchTextField.layer.cornerRadius = 12
        searchTextField.font = UIFont(name: "GothamSSm-Light", size: 13.0)
    }
    
    //Handling if no results by adding Subview says that no results found
    func handleNoResults(){
        let layer = CALayer()
        let NoResultImage = UIImage(named: "undraw_empty_xct9-2")?.cgImage
        layer.frame = CGRect(x: 50, y: Int(UIScreen.main.bounds.midY) - 150, width: Int(Float(UIScreen.main.bounds.width) - 100), height: Int(Float(UIScreen.main.bounds.height) / 4))
        layer.contents = NoResultImage
        let textLayer = CATextLayer()
        textLayer.string = "No results found! \n Perhaps try another search?"
        textLayer.font = UIFont(name: "GothamSSm-Light", size: 16.0)
        textLayer.fontSize = 16
        textLayer.foregroundColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textLayer.isWrapped = true
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: 25, y: Int(UIScreen.main.bounds.midY) + 100 , width: Int(Float(UIScreen.main.bounds.width) - 50), height: Int(Float(UIScreen.main.bounds.height) / 4))
        noDataView.layer.addSublayer(layer)
        noDataView.layer.addSublayer(textLayer)
        self.view.addSubview(noDataView)
        self.noDataView.isHidden = true
    }
}

// MARK: - UITableView
extension HousesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            if HousesViewModel.instance.searchedHouses.isEmpty{
                self.noDataView.isHidden = false
            }
            return HousesViewModel.instance.searchedHouses.count
        } else {
            self.noDataView.isHidden = true
            return HousesViewModel.instance.sortedHouses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = housesTableView.dequeueReusableCell(withIdentifier: "HouseCell") as! HouseCell
        var houseObject = HousesViewModel.instance.sortedHouses[indexPath.row]
        if searching{
            houseObject = HousesViewModel.instance.searchedHouses[indexPath.row]
        }
        self.distances["\(houseObject.id ?? 0)"] = cell.setData(house: houseObject)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "HouseDetails", bundle: nil).instantiateViewController(withIdentifier: "HouseDetailController") as! HouseDetailsViewController
        var selectedHouse = HousesViewModel.instance.sortedHouses[indexPath.row]
        if searching{
            selectedHouse = HousesViewModel.instance.searchedHouses[indexPath.row]
        }
        let selectedId = selectedHouse.id ?? 0
        vc.distance = distances["\(selectedId)"]
        self.searchBar.searchTextField.endEditing(true)
        vc.houseDetail = selectedHouse
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)

    }
}

// MARK: - UISearchBarDelegate
extension HousesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        HousesViewModel.instance.filterContentForSearchText(searchText)
        if searchText.isEmpty{
            searching = false
        }
        else{
            searching = true
        }
        self.getData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.getData()
    }
}
