//
//  AssetsDetailsController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 20/07/22.
//

import UIKit
import SwiftyJSON
protocol AssetsDetailsControllerDelegate{
    func AssetsDetailsFailedResponse(error : String)
    func AssetsDetailsSuccessResponse(dataArr : JSON,msg:String)
}
class AssetsDetailsController: NSObject {
    var delegate : AssetsDetailsControllerDelegate?
    func getAssetsDetails(Param:[String:Any]){
        let api = Constant.Api.ASSET_DETAILS_URL
        print("ASSET_DETAILS_URL api : \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.AssetsDetailsFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.AssetsDetailsFailedResponse(error: "Something went wrong")
                return
            }
            debugPrint(data!)
            self.handleResponse(response: data!)
        })
    }
    
    func handleResponse(response : JSON?)
    {
        if let response = response {
            if response[Constant.Server_Key.code].intValue == 200
            {
                print(response)
                //                guard let dict = response[Constant.Server_Key.data].array else {
                //                    self.delegate?.CheckEmailFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                //                    return
                //                }
                delegate?.AssetsDetailsSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.Code].intValue != 200
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.AssetsDetailsFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.AssetsDetailsFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }
    
    
   // https://6giqs5qy08.execute-api.us-east-1.amazonaws.com/development/atm-profile
    
    
}
