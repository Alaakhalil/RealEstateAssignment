//
//  HousesViewModel.swift
//  RealEstate
//
//  Created by Alaa Khalil on 08/01/2022.
//

import Foundation


class HousesViewModel{
    static let instance = HousesViewModel()
   
    var searchedHouses = [Houses]()
    var sortedHouses = [Houses]()
    var houses = [Houses]()
    
    //Fetch Houses from API
    func fetchHouses(completion: @escaping ((Status) -> Void)) {
        ServerManger.shared.getHouses{ (response, error) in
            if error == nil{
                self.houses = response
                // Ordered houses by cheapest price first
                self.sortedHouses = response.sorted { (first, second) -> Bool in
                    return first.price! < second.price!
                }
                completion(.success)
            }else{
            completion(.failure)
                print("000000000")
            }
        }
    }
    
    // Filter Serachbar text
    func filterContentForSearchText(_ searchText: String) {
        searchedHouses = houses.filter { (house: Houses ) -> Bool in
            let address = house.zip! + " " + house.city!
            let addressInversed = house.city! + " " + house.zip!
            return  address.lowercased().contains(searchText.lowercased()) || addressInversed.lowercased().contains(searchText.lowercased())
        }
    }
}
