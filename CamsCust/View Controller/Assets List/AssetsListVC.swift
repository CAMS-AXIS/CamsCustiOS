//  AssetsListVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 12/05/22.
import UIKit
import SwiftyJSON
class AssetsListVC: UIViewController {
    @IBOutlet weak var assetsListTblVw: UITableView!
    
    @IBOutlet weak var lblActionItemsCount: UILabel!
    @IBOutlet weak var lblAssetCount: UILabel!
    var cell : AssetsListCell = AssetsListCell()
    var objAssetsListController = AssetsListController()
   
    var actionItemParam : [String:Any] = [String:Any]()
    var objAssetsListModel : AssetsListModel?
    var objActionItemListController = ActionItemListController()
    var objActionItemListModel : ActionItemListModel?
    var selectedStr = "assets"
    override func viewDidLoad() {
        super.viewDidLoad()
        objAssetsListController.delegate = self
        objActionItemListController.delegate = self
        self.lblAssetCount.textColor = UIColor.blue
        guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
        DataManager.shared.param[Parameter.AssetsParam.customer_id] = "\(customerID)"
        print(DataManager.shared.param)
        objAssetsListController.AssetList(Param: DataManager.shared.param)
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if DataManager.shared.search_true == "yes"{
            print("---",DataManager.shared.param)
            objAssetsListController.AssetList(Param: DataManager.shared.param)
        }
    }
    
    @IBAction func bttnBack(_ sender: Any) {
        DataManager.shared.search_true = "no"
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func bttnAssetAction(_ sender: Any) {
        self.lblAssetCount.textColor = UIColor.blue
        self.lblActionItemsCount.textColor = UIColor.black
        guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
        DataManager.shared.param[Parameter.AssetsParam.customer_id] = "\(customerID)"
        print(DataManager.shared.param)
        self.selectedStr = "assets"
        objAssetsListController.AssetList(Param: DataManager.shared.param)
    }
    @IBAction func bttnActionItem(_ sender: Any) {
        self.lblAssetCount.textColor = UIColor.black
        self.lblActionItemsCount.textColor = UIColor.blue
        if self.objAssetsListModel?.result.atmList.count != 0{
            guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
                actionItemParam[Parameter.AssetsParam.customer_id] = "\(customerID)"
                actionItemParam["sort_by_asset_id"] = ""
                actionItemParam["sort_by_action_items"] = ""
                actionItemParam["action_item_only"] = 0
                actionItemParam["service_id"] = ""
                actionItemParam["state_code"] = ""
                actionItemParam["city"] = ""
                actionItemParam["atm_manu_id"] = ""
                actionItemParam["atm_model_id"] = ""
                actionItemParam["start_date"] = ""
                actionItemParam["end_date"] = ""
                actionItemParam["question_id"] = ""
                actionItemParam["answer_id"] = ""
                actionItemParam["image_id"] = ""
                actionItemParam["install_type"] = ""
                actionItemParam["atm_id"] = ""
                actionItemParam["category"] = ""
                actionItemParam["sub_categories"] = ""
                print(actionItemParam)
                self.selectedStr = "actions"
                objActionItemListController.ActionItemsList(Param:actionItemParam)
        }
    }
    @IBAction func bttnFilterAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.FilterVC) as? FilterVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
    @IBAction func bttnLocation(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.MapVC) as? MapVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
    func setupTableView(){
        assetsListTblVw.delegate = self
        assetsListTblVw.dataSource = self
        assetsListTblVw.separatorStyle = .none
    }
}
extension AssetsListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.AssetsListCell) as! AssetsListCell
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        cell.bttnActionCount.addTarget(self, action: #selector(showActionItems), for: .touchUpInside)
        cell.bttnActionCount.tag = indexPath.row
        if self.selectedStr == "assets"{
            if let _ = self.objAssetsListModel {
                cell.lblActionCount.isHidden = false
                cell.lblServiceName.text = self.objAssetsListModel?.result.atmList[indexPath.row].institutionAssignedID
                cell.lblDesc.text = self.objAssetsListModel?.result.atmList[indexPath.row].atmDescription
                cell.lblCode.text = self.objAssetsListModel?.result.atmList[indexPath.row].stateCode
                if self.objAssetsListModel?.result.atmList[indexPath.row].actionCount == 0{
                    cell.lblActionCount.backgroundColor = UIColor.blue
                }else{
                    cell.lblActionCount.backgroundColor = UIColor.red
                }
                cell.lblActionCount.text = "\(self.objAssetsListModel?.result.atmList[indexPath.row].actionCount ?? 0)"
                self.cell.imgAsset.sd_setImage(with: URL(string:(self.objAssetsListModel?.result.atmList[indexPath.row].atmMainImage)!), placeholderImage: UIImage(named: "image 16"))
            }
        }else{
            if let _ = self.objActionItemListModel {
                cell.lblServiceName.text = self.objActionItemListModel?.result.actionList[indexPath.row].issueType
                cell.lblDesc.text = self.objActionItemListModel?.result.actionList[indexPath.row].issueDescription
                cell.lblCode.text = self.objActionItemListModel?.result.actionList[indexPath.row].issueSubType
                cell.lblActionCount.isHidden = true
                // cell.lblActionCount.text = "\(self.objActionItemListModel?.result.actionList[indexPath.row].actionCount ?? 0)"
                self.cell.imgAsset.sd_setImage(with: URL(string:(self.objActionItemListModel?.result.actionList[indexPath.row].ImageURL)!), placeholderImage: UIImage(named: "image 16"))
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.AssetDetailsVC) as? AssetDetailsVC
        dashboardVC!.asset_id = "\(self.objAssetsListModel!.result.atmList[indexPath.row].atmid!)"
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedStr == "assets"{
            if let _ = self.objAssetsListModel {
                return self.objAssetsListModel?.result.atmList.count ?? 0
            }else{
                return 0
            }
        }else{
            if let _ = self.objActionItemListModel {
                return self.objActionItemListModel?.result.actionList.count ?? 0
            }else{
                return 0
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    @objc func showActionItems(sender:UIButton){
        self.lblAssetCount.textColor = UIColor.black
        self.lblActionItemsCount.textColor = UIColor.blue
        let atm_id = self.objAssetsListModel?.result.atmList[sender.tag].atmid
        var param : [String:Any] = [String:Any]()
        param[Parameter.AssetsParam.atm_id] = "\(atm_id!)"
        print(param)
        self.selectedStr = "actions"
        objActionItemListController.ActionItemsList(Param:param)
    }
}
extension AssetsListVC:AssetsListControllerDelegate{
    func AssetListFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    
    func AssetListSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
            self.objAssetsListModel = AssetsListModel(myResult: dataArr)
            print("=======++++",self.objAssetsListModel?.result.atmList.count)
            self.lblAssetCount.text = "\(self.objAssetsListModel?.result.atmList.count ?? 0) Assets"
            if self.objAssetsListModel?.result.atmList.count != 0{
            guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
            self.actionItemParam[Parameter.AssetsParam.customer_id] = "\(customerID)"                
                self.actionItemParam["sort_by_asset_id"] = ""
                self.actionItemParam["sort_by_action_items"] = ""
                self.actionItemParam["action_item_only"] = 0
                self.actionItemParam["service_id"] = ""
                self.actionItemParam["state_code"] = ""
                self.actionItemParam["city"] = ""
                self.actionItemParam["atm_manu_id"] = ""
                self.actionItemParam["atm_model_id"] = ""
                self.actionItemParam["start_date"] = ""
                self.actionItemParam["end_date"] = ""
                self.actionItemParam["question_id"] = ""
                self.actionItemParam["answer_id"] = ""
                self.actionItemParam["image_id"] = ""
                self.actionItemParam["install_type"] = ""
                self.actionItemParam["atm_id"] = ""
                self.actionItemParam["category"] = ""
                self.actionItemParam["sub_categories"] = ""
                
            print(self.actionItemParam)
            self.objActionItemListController.ActionItemsList(Param:self.actionItemParam)
            }else{
                self.lblActionItemsCount.text = "0 Action Items"
            }
            self.assetsListTblVw.reloadData()
        })
    }    
}
extension AssetsListVC:ActionItemListControllerDelegate{
    func ActionItemsListFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    func ActionItemsListSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
            self.objActionItemListModel = ActionItemListModel(Dict: dataArr)
            print("-----++++",self.objActionItemListModel?.result.actionList.count)
            if self.objActionItemListModel?.result.actionList.count != 0{
                self.lblActionItemsCount.text = "\(self.objActionItemListModel?.result.actionList.count ?? 0) Action Items"
            }
            self.assetsListTblVw.reloadData()
            
        })
    }
    
    
}
