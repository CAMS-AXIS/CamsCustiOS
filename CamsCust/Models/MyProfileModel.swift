//
//  MyProfileModel.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 21/06/22.
//

import UIKit
import SwiftyJSON
class MyProfileModel: NSObject {
    let message: String
    let code: Int
    let data: ProfileData
    init(Dict:JSON) {
        self.message = Dict["message"].stringValue
        self.code = Dict["code"].intValue
        self.data = ProfileData(MyDict: Dict["data"])
    }
}

// MARK: - DataClass
class ProfileData: NSObject {
    let userName:String?
    let userID: String?
    let email: String?

    init(MyDict:JSON) {
        self.userID = MyDict["UserId"].stringValue
        self.userName = MyDict["UserName"].stringValue
        self.email = MyDict["Email"].stringValue
    }
}
