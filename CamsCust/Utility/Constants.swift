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
        static let BASE_URL = "https://pf1rturvya.execute-api.us-east-1.amazonaws.com/development/"
        static let LOGIN = BASE_URL + "admin-login"
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
}
