//
//  ChangePasswordController.swift
//  CamsCust
//  Created by Dipika Ghosh on 05/07/22.
import UIKit
import SwiftyJSON
protocol ChangePasswordControllerDelegate{
    func changePasswordFailedResponse(error : String)
    func changePasswordSuccessResponse(dataArr : JSON,msg:String)
}
class ChangePasswordController: NSObject {
    var delegate : ChangePasswordControllerDelegate?
    func changePassword(Param:[String:Any]){
        let api = Constant.Api.CHANGE_PASSWORD_URL
        print("CHANGE_PASSWORD_URL api : \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.changePasswordFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.changePasswordFailedResponse(error: "Something went wrong")
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
                delegate?.changePasswordSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.Code].intValue != 200
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.changePasswordFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.changePasswordFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }

}
