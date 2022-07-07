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
        
        static let SWITCH_ACCOUNT_URL = "https://m3gv0ee1fb.execute-api.us-east-1.amazonaws.com/development/bank-list"
        static let FILTER_LIST_URL = "https://kfnvcq6f56.execute-api.us-east-1.amazonaws.com/prod/prod_customer_asset_list_dropdown"
        static let CHANGE_PASSWORD_URL = "https://tpmk3qt4x8.execute-api.us-east-1.amazonaws.com/development/change-password"
        
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
        static let MyProfileCell2 = "MyProfileCell2"
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
        static let Current_Password_Error               = "Please enter your current password"
        static let New_Password_Error                   = "Please enter your new password"
        static let Confirm_Password_Error               = "Please enter your confirm pasword"
        static let Current_password_Error               = "Please enter your current password correctly"
        static let Same_Password_Error                  = "New password and confirm password should be same"
        
        static let Password_match_error                  = "Password should contain one upper case,one lower case and one digit"


    }
    struct user_defaults_value
    {
        static let customerID                                    = "customer_id"
        static let username                                      = "username"
        static let customerLogo                                  = "customer_logo"
        static let password                                      = "password"
        static let user_id                                       = "user_id"
        
    }
}
