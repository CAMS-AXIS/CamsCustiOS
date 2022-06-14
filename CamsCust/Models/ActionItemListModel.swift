//
//  ActionItemListModel.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 14/06/22.
//

import UIKit
import SwiftyJSON
// MARK: - ActionItemListModel
class ActionItemListModel: NSObject {
    let result: ResultActionList
    let isSuccess: Bool
    let message:String
    let code: String
    
    init(Dict:JSON) {
        self.isSuccess = Dict["is_success"].boolValue
        self.message = Dict["message"].stringValue
        self.code = Dict["code"].stringValue
        self.result = ResultActionList(resultDict: Dict["result"])
    }
}

// MARK: - Result
class ResultActionList: NSObject {
    var actionList = [ActionList]()
    init(resultDict:JSON) {
        if let arr = resultDict["action_list"].array
        {
            for item in arr
            {
                let obj = ActionList(ActionDict: item)
                self.actionList.append(obj)
            }
        }
    }
}

// MARK: - ActionList
class ActionList: NSObject {
    let issueSubType: String?
    let answerIssueID: Int?
    let atmid:Int?
    let jobID: Int?
    let issueDescription:String?
    let imageID: String?
    let issueType: String?
    let imageName: String?
    let imageBaseURL: String?
    let ImageURL: String?
    let Extension: String?

    init(ActionDict:JSON) {
        self.issueSubType = ActionDict["IssueSubType"].stringValue
        self.answerIssueID = ActionDict["AnswerIssueId"].intValue
        self.issueDescription = ActionDict["IssueDescription"].stringValue
        self.imageID = ActionDict["ImageId"].stringValue
        self.imageName = ActionDict["ImageName"].stringValue
        self.imageBaseURL = ActionDict["ImageBaseURL"].stringValue
        self.atmid = ActionDict["ATMID"].intValue
        self.jobID = ActionDict["JobId"].intValue
        self.Extension = ActionDict["Extension"].stringValue
        self.issueType = ActionDict["IssueType"].stringValue
        self.ImageURL = ActionDict["ImageURL"].stringValue
    }
}

