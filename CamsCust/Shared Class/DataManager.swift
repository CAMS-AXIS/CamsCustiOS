//  DataManager.swift
//  Back4App
//  Created by webskitters on 16/01/20.
//  Copyright © 2020 webskitters. All rights reserved.
import UIKit
import SVProgressHUD

class DataManager: NSObject {
     private override init() { }
    static let shared                                       = DataManager()
    public let apiManager : APIManager                      = APIManager()
    public var firstTimeUser : Bool?
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
    let ACCEPTABLE_CHARACTERS_PHONE = "0123456789()-+ "
    let ACCEPTABLE_CHARACTERS_COMMON = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890,.- "
    let ACCEPTABLE_CHARACTERS_CARD = "0123456789 "
    let ACCEPTABLE_CHARACTERS_VERIFY = "0123456789"
    let ACCEPTABLE_CHARACTERS_ZIPCODE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "
   
   var search_true = ""
    var param :[String:Any] = [Parameter.AssetsParam.action_item_only:"",
                               Parameter.AssetsParam.answer_id:"",
                               Parameter.AssetsParam.atm_id : "",
                               Parameter.AssetsParam.atm_manu_id : "",
                               Parameter.AssetsParam.atm_model_id:"",
                               Parameter.AssetsParam.category:"",
                               Parameter.AssetsParam.city:"",
                               Parameter.AssetsParam.customer_id:"",
                               Parameter.AssetsParam.end_date:"",
                               Parameter.AssetsParam.image_id:"",
                               Parameter.AssetsParam.install_type:"",
                               Parameter.AssetsParam.question_id:"",
                               Parameter.AssetsParam.service_id:"",
                               Parameter.AssetsParam.sort_by_action_items:"",
                               Parameter.AssetsParam.sort_by_asset_id:"",
                               Parameter.AssetsParam.start_date:"",
                               Parameter.AssetsParam.state_code : "",
                               Parameter.AssetsParam.sub_categories:""
    ]
    
    
    public func showLoader() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.show()
    }
    func showLoader(text:String) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
        //SVProgressHUD.setFont(UIFont.fontWorkSansMedium(fontSize: 14.0)!)
        SVProgressHUD.show(withStatus: text)
    }
    func showLoaderWithInteractionOn() {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
        SVProgressHUD.show()
    }
    func showLoaderWithInteractionOn(text:String) {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
       // SVProgressHUD.setFont(UIFont.familyNames()
        SVProgressHUD.show(withStatus: text)
    }
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    func hideLoader(delay:TimeInterval) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
//    func UnableToFindUser()
//    {
//        Utility.removeObjectFromUserDefaults(forKey: Constant.user_defaults_value.user_id)
//        Utility.removeObjectFromUserDefaults(forKey: Constant.user_defaults_value.access_token)
//        Utility.removeObjectFromUserDefaults(forKey: Constant.user_defaults_value.isVerified)
//        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nav = mainStoryboardIpad.instantiateViewController(withIdentifier: "RootNavigationVC") as! RootNavigationVC
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = nav
//        appDelegate.window?.makeKeyAndVisible()
//    }

}
