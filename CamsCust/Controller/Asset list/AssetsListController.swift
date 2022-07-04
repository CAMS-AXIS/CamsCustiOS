//
//  AssetsListController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 06/06/22.
//

import UIKit
import SwiftyJSON
protocol AssetsListControllerDelegate{
    func AssetListFailedResponse(error : String)
    func AssetListSuccessResponse(dataArr : JSON,msg:String)
}
class AssetsListController: NSObject {
    var delegate : AssetsListControllerDelegate?
    func AssetList(Param:[String:Any]){
        let api = Constant.Api.ASSETS_LIST_URL
        print("ASSETS_LIST_URL api : \(api)")
        DataManager.shared.showLoader()
        DataManager.shared.apiManager.sendPostRequest(Param, withMethod: api, withCompletion: {( data: JSON?,  response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                self.delegate?.AssetListFailedResponse(error: error!.localizedDescription)
                return
            }
            guard let _ = data else {
                self.delegate?.AssetListFailedResponse(error: "Something went wrong")
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
                delegate?.AssetListSuccessResponse(dataArr: response, msg: response[Constant.Server_Key.message].stringValue)
            }
            else if response[Constant.Server_Key.Code].intValue != 200
            {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.AssetListFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                    
                })
            }
            else{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.AssetListFailedResponse(error: response[Constant.Server_Key.message].stringValue)
                })
            }
        }
    }
    
}

