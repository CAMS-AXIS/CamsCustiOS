//
//  MapVC+API.swift
//  CamsCust
//
//  Created by charanjit singh on 12/07/22.
//

import Foundation
import Alamofire
import SwiftyJSON


extension MapVC {
    
    
    func getMapPinDetails() {
        let urlString = "\(Constant.Api.MAP_ASSET_PIN)"
        
        guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
        let params:[String:Any] = ["CustomerId": "\(customerID)"]
        
        
        let request = AF.request(urlString, method: .post,parameters: params, encoding: JSONEncoding.default).validate()
        
        
        request.responseData { response in
            guard let data = response.data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(MapsPinsModel.self, from: data)
                print(responseModel)
                self.assetList = responseModel.data
                self.reloadMap()
                
            
            } catch {
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    
}
