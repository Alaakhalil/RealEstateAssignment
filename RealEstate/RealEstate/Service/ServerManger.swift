//
//  ServerManger.swift
//  RealEstate
//
//  Created by Alaa Khalil on 08/01/2022.
//

import Foundation
import Alamofire

class ServerManger {
    static let shared = ServerManger()
    
    func getHouses(completion: @escaping (_ response: [Houses], _ error: String?) -> Void)-> Void{
        AF.request(houseUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 199..<300).responseDecodable { (response: DataResponse<[Houses], AFError>) in
            switch response.result{
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                print("There is an error with get houses:: \(error.localizedDescription)")
            }
        }
    }
}

extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: AFDataResponse<Any>) -> AFResult<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            print("Didn't get any data from API")
            return .failure(response.error!)
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("Error trying to decode response")
            print(error)
            return .failure(error as! AFError)
        }
    }
}

