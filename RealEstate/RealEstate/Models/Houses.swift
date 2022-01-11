//
//  Houses.swift
//  RealEstate
//
//  Created by Alaa Khalil on 08/01/2022.
//


import Foundation

struct Houses : Codable {
    let id : Int?
    let image : String?
    let price : Int?
    let bedrooms : Int?
    let bathrooms : Int?
    let size : Int?
    let description : String?
    let zip : String?
    let city : String?
    let latitude : Int?
    let longitude : Int?
    let createdDate : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case image = "image"
        case price = "price"
        case bedrooms = "bedrooms"
        case bathrooms = "bathrooms"
        case size = "size"
        case description = "description"
        case zip = "zip"
        case city = "city"
        case latitude = "latitude"
        case longitude = "longitude"
        case createdDate = "createdDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        bedrooms = try values.decodeIfPresent(Int.self, forKey: .bedrooms)
        bathrooms = try values.decodeIfPresent(Int.self, forKey: .bathrooms)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        latitude = try values.decodeIfPresent(Int.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Int.self, forKey: .longitude)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
    }

}
