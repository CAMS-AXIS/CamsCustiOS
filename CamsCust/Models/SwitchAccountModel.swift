//
//  SwitchAccountModel.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 27/06/22.
//

import UIKit
import SwiftyJSON
class SwitchAccountModel: NSObject {
    var data = [SwitchAccountData]()
    let msg: String?
    let code: Int?
    
    init(MyDict:JSON) {
        self.code = MyDict["code"].intValue
        self.msg = MyDict["msg"].stringValue
        
        
        
        if let arr = MyDict["data"].array
        {
            for item in arr
            {
                let obj = SwitchAccountData(AccountData: item)
                self.data.append(obj)
            }
        }
        
    }
    
}


// MARK: - Datum
class SwitchAccountData: NSObject {
    let customerName: String?
    let customerID: Int?
    let CustomerLogo : String?
    
    init(AccountData:JSON) {
        self.customerID = AccountData["CustomerId"].intValue
        self.customerName = AccountData["CustomerName"].stringValue
        self.CustomerLogo = AccountData["CustomerLogo"].stringValue
    }
}
