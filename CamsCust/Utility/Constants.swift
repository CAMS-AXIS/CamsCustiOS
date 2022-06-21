//
//  Constants.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 10/05/22.
//
import Foundation
import UIKit

struct Constant {
    struct Api {
      //  https://pf1rturvya.execute-api.us-east-1.amazonaws.com/development/admin-login
     //   https://6y03b2vgv2.execute-api.us-east-1.amazonaws.com/development/admin-dashboard-customer
        static let BASE_URL = "https://pf1rturvya.execute-api.us-east-1.amazonaws.com/development/"
        static let LOGIN = BASE_URL + "admin-login"
        static let DASHBOARD_URL = "https://6y03b2vgv2.execute-api.us-east-1.amazonaws.com/development/admin-dashboard-customer"
        static let FORGOT_PASSWOORD_URL = "https://4x13tqxrhh.execute-api.us-east-1.amazonaws.com/prod/prod-forgot-password"
        static let ASSETS_LIST_URL = "https://f2p75h4j1j.execute-api.us-east-1.amazonaws.com/development/asset_list_customer"
        static let ACTIONS_ITEMS_LIST_URL = "https://6caq8xuul4.execute-api.us-east-1.amazonaws.com/development/asset-list-action-items"
        static let MY_PROFILE_URL = "https://6uxjma7cc1.execute-api.us-east-1.amazonaws.com/development/profile-view"
    }
    struct CellIdentifier {
        static let DashboardCollectionCell = "DashboardCollectionCell"
        static let LoginCell = "LoginCell"
        static let SwitchAccountCell = "SwitchAccountCell"
        static let AssetsListCell = "AssetsListCell"
        static let FilterCell = "FilterCell"
        static let FilterCell2 = "FilterCell2"
        static let FilterSearchCell = "FilterSearchCell"
        static let AssetDetailsCell = "AssetDetailsCell"
        static let AssetsCollectionCell = "AssetsCollectionCell"
        static let ActionItemCell = "ActionItemCell"
        static let SelectSurveyCell = "SelectSurveyCell"
        static let ReviewSurveyCell = "ReviewSurveyCell"
        static let MyProfileCell = "MyProfileCell"
    }
    struct StoryboardIdentifier {
        static let AssetsListVC = "AssetsListVC"
        static let DashboardVC = "DashboardVC"
        static let ForgotPasswordVC = "ForgotPasswordVC"
        static let FilterVC = "FilterVC"
        static let FilterSearchVC = "FilterSearchVC"
        static let MapVC = "MapVC"
        static let AssetDetailsVC = "AssetDetailsVC"
        static let SelectSurveyVC = "SelectSurveyVC"
        static let ReviewSurveyVC = "ReviewSurveyVC"
    }
    struct Server_Key {
        static let code = "code"
        static let Code = "Code"
        static let data = "data"
        static let message = "message"
        static let token = "token"
        static let suggestions = "suggestions"
        static let totalPageCount = "totalPageCount"
        static let success = "success"
       
        
    }
    struct variableText
    {
        static let appName                            = "CamsCust"
        static let ok                                 = "okay"
        static let InvisibleSign = "\u{200B}"

    }
    struct Error_Message {
        static let Username_Error                       = "Please enter your Name"
        static let Password_Error                       = "Please enter password"
        static let PasswordCount_Error                  = "Password should be minimum of 6 characters"
    }
    struct user_defaults_value
    {
        static let customerID                                    = "customer_id"
        static let username                                      = "username"
        static let customerLogo                                  = "customer_logo"
       
        
    }
}
