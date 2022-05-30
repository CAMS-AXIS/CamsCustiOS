//
//  DashboardController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 27/05/22.
//

import UIKit
import SwiftyJSON
protocol DashboardControllerDelegate{
    func dashboardFailedResponse(error : String)
    func dashboardSuccessResponse(dataArr : JSON,msg:String)
}
class DashboardController: NSObject {
    var delegate : DashboardControllerDelegate?
    func DashboardDetails(Param:[String:Any]){
        let api = Constant.Api.DASHBOARD_URL
        print("DASHBOARD api :  \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.dashboardFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.dashboardFailedResponse(error: "Something went wrong")
                return
            }
            debugPrint(data!)
            self.handleResponse(response: data!)
        })
    }
    
    func handleResponse(response : JSON?)
    {
        if let response = response {
            if response[Constant.Server_Key.Code].intValue == 200
            {
                print(response)
                //                guard let dict = response[Constant.Server_Key.data].array else {
                //                    self.delegate?.CheckEmailFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                //                    return
                //                }
                delegate?.dashboardSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.Code].intValue != 200
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.dashboardFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.dashboardFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }

}
