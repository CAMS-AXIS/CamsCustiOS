//
//  ActionItemListController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 13/06/22.
//

import UIKit
import SwiftyJSON
protocol ActionItemListControllerDelegate{
    func ActionItemsListFailedResponse(error : String)
    func ActionItemsListSuccessResponse(dataArr : JSON,msg:String)
}
class ActionItemListController: NSObject {
    var delegate : ActionItemListControllerDelegate?
    func ActionItemsList(Param:[String:Any]){
        let api = Constant.Api.ACTIONS_ITEMS_LIST_URL
        print("ACTION_ITEMS_LIST_URL api : \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.ActionItemsListFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.ActionItemsListFailedResponse(error: "Something went wrong")
                return
            }
            debugPrint(data!)
            self.handleResponse(response: data!)
        })
    }
    
    
    func handleResponse(response : JSON?)
    {
        if let response = response {
            if response[Constant.Server_Key.code].stringValue == "200"
            {
                print(response)
                //                guard let dict = response[Constant.Server_Key.data].array else {
                //                    self.delegate?.CheckEmailFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                //                    return
                //                }
                delegate?.ActionItemsListSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.code].stringValue != "200"
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.ActionItemsListFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.ActionItemsListFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }
    
    
    
    
    
}
