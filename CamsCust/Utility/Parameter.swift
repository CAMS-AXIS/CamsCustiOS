//
//  Parameter.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 25/05/22.
//

import Foundation
struct Parameter {
struct LoginParam {
    static let password                     = "password"
    static let email                        = "username"
    static let device_token                 = "DeviceToken"
    static let device_type                  = "DeviceType"
}
    struct DashboardParam {
        static let customer_id = "customer_id"
    }
    struct ForgotPasswordParam {
        static let email = "email"
    }
    struct AssetsParam {
        static let customer_id = "customer_id"
        static let sort_by_asset_id = "sort_by_asset_id"
        static let sort_by_action_items = "sort_by_action_items"
        static let action_item_only = "action_item_only"
        static let service_id = "service_id"
        static let state_code = "state_code"
        static let city = "city"
        static let atm_manu_id = "atm_manu_id"
        static let atm_model_id = "atm_model_id"
        static let start_date = "start_date"
        static let end_date = "end_date"
        static let question_id = "question_id"
        static let answer_id = "answer_id"
        static let image_id = "image_id"
        static let install_type = "install_type"
        static let atm_id = "atm_id"
        static let sub_categories = "sub_categories"
        static let category = "category"
        
    }
    
}
