//
//  LoginModel.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 25/05/22.
//

import UIKit
import SwiftyJSON

class LoginModel: NSObject {
    let isSuccess: Bool?
    let message: String?
    let data: LoginData?
    let code: Int?

   
    init(dataDict:JSON) {
        self.code = dataDict["code"].intValue
        self.isSuccess = dataDict["is_success"].boolValue
        self.message = dataDict["message"].stringValue
        self.data = LoginData(MyData: dataDict["data"])
        
    }
    
}

// MARK: - DataClass
class LoginData: NSObject {
    let customerID: Int?
    let customerLogo: String?
    let roleID : String?
    let role : String?
    let username: String?
    
    
    init(MyData:JSON) {
        self.customerID = MyData["customer_id"].intValue
        self.customerLogo = MyData["customer_logo"].stringValue
        self.roleID = MyData["role_id"].stringValue
        self.role = MyData["role"].stringValue
        self.username = MyData["username"].stringValue
    }
  
}
