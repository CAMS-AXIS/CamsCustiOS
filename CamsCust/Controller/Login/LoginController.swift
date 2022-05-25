//
//  LoginController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 25/05/22.
//

import UIKit
import SwiftyJSON
protocol LoginControllerDelegate{
    func loginFailedResponse(error : String)
    func loginSuccessResponse(dataArr : JSON,msg:String)
}
class LoginController: NSObject {
    var delegate : LoginControllerDelegate?
    func Login(Param:[String:Any]){
        let api = Constant.Api.LOGIN
        print("Login api :  \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.loginFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.loginFailedResponse(error: "Something went wrong")
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
                delegate?.loginSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.code].intValue != 200
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.loginFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.loginFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }
}
