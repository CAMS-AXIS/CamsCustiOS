//
//  SwitchAccountController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 23/06/22.
//

import UIKit
import SwiftyJSON
protocol SwitchAccountControllerDelegate{
    func getAccountListFailedResponse(error : String)
    func getAccountListSuccessResponse(dataArr : JSON,msg:String)
}
class SwitchAccountController: NSObject {
    var delegate : SwitchAccountControllerDelegate?
    func getAccountList(Param:[String:Any]){
        let api = Constant.Api.SWITCH_ACCOUNT_URL
        print("SWITCH_ACCOUNT_URL api : \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.getAccountListFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.getAccountListFailedResponse(error: "Something went wrong")
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
                delegate?.getAccountListSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.Code].intValue != 200
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.getAccountListFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.getAccountListFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }

}
