//  DashboardModel.swift
//  CamsCust
//  Created by Dipika Ghosh on 27/05/22.
import UIKit
import SwiftyJSON
// MARK: - DashboardModel
class DashboardModel: NSObject {
    let data: DashboardData?
    let code: Int?
    let isSuccess: Bool?
    init(dataDict:JSON) {
        self.code = dataDict["code"].intValue
        self.isSuccess = dataDict["is_success"].boolValue
        self.data = DashboardData(Mydata: dataDict["data"])
    }
}
// MARK: - DataClass
class DashboardData: NSObject {
    let assetCount: Int?
    var tiles = [Tile]()
    let actionItems: Int?
    init(Mydata:JSON) {
        self.assetCount = Mydata["asset_count"].intValue
        self.actionItems = Mydata["action_items"].intValue
        if let arr = Mydata["tiles"].array
        {
            for item in arr
            {
                let obj = Tile(tilesData: item)
                self.tiles.append(obj)
            }
        }
    }
}
// MARK: - Tile
class Tile: NSObject {
    let issueCategory: String?
    let kpiPercentage: Double?
    let colorCode: String?
    let kpiCount: Int?
    init(tilesData:JSON) {
        self.issueCategory = tilesData["IssueCategory"].stringValue
        self.kpiPercentage = tilesData["KpiPercentage"].doubleValue
        self.colorCode = tilesData["ColorCode"].stringValue
        self.kpiCount = tilesData["KpiCount"].intValue
    }
}
