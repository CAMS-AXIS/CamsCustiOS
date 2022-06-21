//
//  MyProfileController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 21/06/22.
//

import UIKit
import SwiftyJSON
protocol MyProfileControllerDelegate{
    func getProfileFailedResponse(error : String)
    func getProfileSuccessResponse(dataArr : JSON,msg:String)
}

class MyProfileController: NSObject {
    var delegate : MyProfileControllerDelegate?
    
    func getProfileDetails(Param:[String:Any]){
        let api = Constant.Api.MY_PROFILE_URL
        print("MY_PROFILE_URL api : \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.getProfileFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.getProfileFailedResponse(error: "Something went wrong")
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
                delegate?.getProfileSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.Code].intValue != 200
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.getProfileFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.getProfileFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }
}
