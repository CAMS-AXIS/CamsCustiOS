//
//  AssetsDetailsModel.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 20/07/22.
//

import UIKit
import SwiftyJSON
// MARK: - AssetsDetailsModel
class AssetsDetailsModel: NSObject {
    let code: Int
    let msg: String
    let data: assetsDetailsData?
    init(objAssets:JSON) {
        self.code = objAssets["code"].intValue
        self.msg = objAssets["msg"].stringValue
        self.data = assetsDetailsData(assetsDetailsData:objAssets["data"])
    }
}

// MARK: - DataClass
class assetsDetailsData: NSObject {
    var serviceImages = [serviceImage]()
    let atmInfo: ATMInfo
    var atmImages = [allAtmImages]()
    let atmMap: ATMMap
  //  let actionItems: [JSONAny]
    var services = [ServiceList]()
    init(assetsDetailsData:JSON) {
        if let arr = assetsDetailsData["serviceImages"].array
        {
            for item in arr
            {
                let obj = serviceImage(objService: item)
                self.serviceImages.append(obj)
            }
        }
        if let arr = assetsDetailsData["atmImages"].array
        {
            for item in arr
            {
                let obj = allAtmImages(objAllAtmImages: item)
                self.atmImages.append(obj)
            }
        }
        self.atmInfo = ATMInfo(objAtmInfo:assetsDetailsData["atmInfo"])
        self.atmMap = ATMMap(objAtmMap:assetsDetailsData["atmMap"])
        
        if let arr = assetsDetailsData["atmImages"].array
        {
            for item in arr
            {
                let obj = ServiceList(objServiceList: item)
                self.services.append(obj)
            }
        }
        
    }
}

// MARK: - Image
class serviceImage: NSObject {
    let imageURL: String?
    let imageName: String?

    init(objService:JSON) {
        self.imageURL = objService["ImageName"].stringValue
        self.imageName = objService["imageURL"].stringValue
    }
    
}
class allAtmImages : NSObject{
    let imageURL: String?
    let imageName: String?
    init(objAllAtmImages:JSON) {
        self.imageURL = objAllAtmImages["ImageName"].stringValue
        self.imageName = objAllAtmImages["imageURL"].stringValue
    }
}

// MARK: - ATMInfo
struct ATMInfo: Codable {
    //let locationDescription: JSONNull?
    let locationID : Int?
    let atmid: Int?
    let atmDescription : String?
    let atmModel : String?
    let institutionAssignedID : String?
    let comments : String?
   // let s3Path: JSONNull?

    init(objAtmInfo:JSON) {
        self.locationID = objAtmInfo["LocationID"].intValue
        self.atmid = objAtmInfo["ATMID"].intValue
        self.atmDescription = objAtmInfo["ATMDescription"].stringValue
        self.atmModel = objAtmInfo["ATMModel"].stringValue
        self.institutionAssignedID = objAtmInfo["InstitutionAssignedID"].stringValue
        self.comments = objAtmInfo["Comments"].stringValue
    }
    
}

// MARK: - ATMMap
struct ATMMap: Codable {
    let latitude : String?
    let atmDescription : String?
    let longitude : String?
    init(objAtmMap:JSON) {
        self.latitude = objAtmMap["Latitude"].stringValue
        self.longitude = objAtmMap["Longitude"].stringValue
        self.atmDescription = objAtmMap["ATMDescription"].stringValue
    }
}

// MARK: - Service
class ServiceList: NSObject {
    let time : String?
    let serviceName : String?
    let serviceInstanceID: Int?
    let date: String?
    
    init(objServiceList:JSON) {
        self.time = objServiceList["time"].stringValue
        self.serviceName = objServiceList["ServiceName"].stringValue
        self.serviceInstanceID = objServiceList["ServiceInstanceId"].intValue
        self.date = objServiceList["date"].stringValue
    }

}

