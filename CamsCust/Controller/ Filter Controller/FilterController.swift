//
//  FilterController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 28/06/22.
//

import UIKit
import SwiftyJSON
protocol FilterControllerDelegate{
    func FilterListFailedResponse(error : String)
    func FilterListSuccessResponse(dataArr : JSON,msg:String)
}
class FilterController: NSObject {
    var delegate : FilterControllerDelegate?
    func getFilterList(Param:[String:Any]){
        let api = Constant.Api.FILTER_LIST_URL
        print("FILTER_LIST_URL api : \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.FilterListFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.FilterListFailedResponse(error: "Something went wrong")
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
                delegate?.FilterListSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.Code].intValue != 200
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.FilterListFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.FilterListFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }

}
//https://kfnvcq6f56.execute-api.us-east-1.amazonaws.com/prod/prod_customer_asset_list_dropdown
