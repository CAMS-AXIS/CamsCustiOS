//
//  AssetsListModel.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 07/06/22.
//

import UIKit
import SwiftyJSON
// MARK: - AssetsListModel
class AssetsListModel: NSObject {
    let result: Result
   
    init(myResult:JSON) {
        self.result = Result(Mydata: myResult["result"])
    }
    
}

// MARK: - Result
class Result: NSObject {
    let len: Int
    var atmList = [ATMList]()
    let code: Int

//    enum CodingKeys: String, CodingKey {
//        case len
//        case atmList = "atm_list"
//        case code = "Code"
//    }
    init(Mydata:JSON) {
        self.len = Mydata["len"].intValue
        self.code = Mydata["Code"].intValue
        
        if let arr = Mydata["atm_list"].array
        {
            for item in arr
            {
                let obj = ATMList(ListData: item)
                self.atmList.append(obj)
            }
        }
    }
    
    
    
}

// MARK: - ATMList
class ATMList: NSObject {
    let serviceName: String
    let locationID : Int?
    let actionCount: Int?
    let address1: String
    let fieldComplete: String?
    let atmDescription: String?
    let atmMainImage:String?
    let postalCode : String?
    let city : String?
    let atmid: Int?
    let stateCode : String?
    let institutionAssignedID: String?
    
    init(ListData:JSON) {
        self.serviceName = ListData["ServiceName"].stringValue
        self.locationID = ListData["LocationID"].intValue
        self.actionCount = ListData["action_count"].intValue
        self.address1 = ListData["address1"].stringValue
        self.fieldComplete = ListData["fieldComplete"].stringValue
        self.atmDescription = ListData["ATMDescription"].stringValue
        self.atmMainImage = ListData["atm_main_image"].stringValue
        self.postalCode = ListData["postalCode"].stringValue
        self.city = ListData["City"].stringValue
        self.stateCode = ListData["StateCode"].stringValue
        self.atmid = ListData["atmid"].intValue
        self.institutionAssignedID = ListData["InstitutionAssignedID"].stringValue

        
    }

}


