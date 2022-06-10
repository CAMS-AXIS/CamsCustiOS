//  ForgotPasswordController.swift
//  CamsCust
//  Created by Dipika Ghosh on 01/06/22.
import UIKit
import SwiftyJSON
protocol ForgotPasswordControllerDelegate{
    func forgotPasswordFailedResponse(error : String)
    func forgotPasswordSuccessResponse(dataArr : JSON,msg:String)
}
class ForgotPasswordController: NSObject {
   
        var delegate : ForgotPasswordControllerDelegate?
        func forgotPassword(Param:[String:Any]){
            let api = Constant.Api.FORGOT_PASSWOORD_URL
            print("forgot password api :  \(api)")
            DataManager.shared.showLoader()
            DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
                if error != nil {
                    self.delegate?.forgotPasswordFailedResponse(error: error!.localizedDescription)
                    return
                }
                guard let _ = data else {
                    self.delegate?.forgotPasswordFailedResponse(error: "Something went wrong")
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
                    delegate?.forgotPasswordSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
                }
                else if response[Constant.Server_Key.code].intValue != 200
                {
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.delegate?.forgotPasswordFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                        
                    })
                }
                else{
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.delegate?.forgotPasswordFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    })
                }
            }
        }
    }

