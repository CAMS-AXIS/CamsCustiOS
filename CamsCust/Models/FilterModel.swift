//
//  FilterModel.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 29/06/22.
//

import UIKit
import SwiftyJSON

class FilterModel: NSObject {
    let isSuccess: Bool?
    let code: Int?
    let result: ResultData
    let message: String?

    init(MyData:JSON) {
        self.isSuccess = MyData["is_success"].boolValue
        self.code = MyData["code"].intValue
        self.message = MyData["message"].stringValue
        self.result = ResultData(ResultObj:MyData["result"])
    }
}

// MARK: - Result
class ResultData: NSObject {
    let answerList = [String]()
    var imageList = [ImageList]()
    let installType: InstallType
    let question = [String]()
    var serviceName = [ServiceName]()
    var manufacturerList = [ManufacturerList]()
    var states = [State]()
    
    init(ResultObj : JSON) {
        
        self.installType = InstallType(InstallObj:ResultObj["install_type"])
        
        if let arr = ResultObj["image_list"].array
        {
            for item in arr
            {
                let obj = ImageList(ImageData: item)
                self.imageList.append(obj)
            }
        }
        
        if let arr = ResultObj["service_name"].array
        {
            for item in arr
            {
                let obj = ServiceName(ServiceNameObj: item)
                self.serviceName.append(obj)
            }
        }
        
        if let arr = ResultObj["manufacturer_list"].array
        {
            for item in arr
            {
                let obj = ManufacturerList(ManufactureListObj: item)
                self.manufacturerList.append(obj)
            }
        }
        if let arr = ResultObj["states"].array
        {
            for item in arr
            {
                let obj = State(StateObj: item)
                self.states.append(obj)
            }
        }
        
        
        
    }

//    enum CodingKeys: String, CodingKey {
//        case answerList = "answer_list"
//        case imageList = "image_list"
//        case installType = "install_type"
//        case question = "Question"
//        case serviceName = "service_name"
//        case manufacturerList = "manufacturer_list"
//        case states
//    }
}

// MARK: - ImageList
class ImageList: NSObject {
    let imageID : String?
    let imageName: String?
    init(ImageData:JSON) {
        self.imageID = ImageData["image_id"].stringValue
        self.imageName = ImageData["image_name"].stringValue
    }
}

// MARK: - InstallType
class InstallType: NSObject {
    let interior:String?
    let throughTheWall:String?
    let exterior:String?
    let driveUp: String?
    let freestanding:String?
    let kiosk:String?
    let walkUp: String?

    init(InstallObj:JSON) {
        self.interior = InstallObj["Interior"].stringValue
        self.throughTheWall = InstallObj["ThroughTheWall"].stringValue
        self.exterior = InstallObj["Exterior"].stringValue
        self.driveUp = InstallObj["DriveUp"].stringValue
        self.freestanding = InstallObj["Freestanding"].stringValue
        self.kiosk = InstallObj["Kiosk"].stringValue
        self.walkUp = InstallObj["walkUp"].stringValue
    }
}

// MARK: - ManufacturerList
class ManufacturerList: NSObject {
    let manufacturerName: String?
    let manufacturerID: Int?
    
    init(ManufactureListObj:JSON) {
        self.manufacturerID = ManufactureListObj["manufacturer_id"].intValue
        self.manufacturerName = ManufactureListObj["manufacturer_name"].stringValue
    }
}

// MARK: - ServiceName
class ServiceName: NSObject {
    let serviceID: Int?
    let serviceName: String?
    
    init(ServiceNameObj:JSON) {
        self.serviceID = ServiceNameObj["service_id"].intValue
        self.serviceName = ServiceNameObj["service_name"].stringValue
    }

}

// MARK: - State
class State: NSObject {
    let stateID: String?
    
    init(StateObj:JSON) {
        self.stateID = StateObj["state_id"].stringValue
    }

}

