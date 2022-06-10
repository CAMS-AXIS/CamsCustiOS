//  AssetsListVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 12/05/22.
import UIKit
import SwiftyJSON
class AssetsListVC: UIViewController {
    @IBOutlet weak var assetsListTblVw: UITableView!
    
    @IBOutlet weak var lblAssetCount: UILabel!
    var cell : AssetsListCell = AssetsListCell()
    var objAssetsListController = AssetsListController()
    var param :[String:Any] = [Parameter.AssetsParam.action_item_only:0,
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
    
    var objAssetsListModel : AssetsListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        objAssetsListController.delegate = self
        guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
        param[Parameter.AssetsParam.customer_id] = "\(customerID)"
        print(param)
        objAssetsListController.AssetList(Param: param)
        setupTableView()

    }
    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        if let _ = self.objAssetsListModel {
            cell.lblServiceName.text = self.objAssetsListModel?.result.atmList[indexPath.row].serviceName
            cell.lblDesc.text = self.objAssetsListModel?.result.atmList[indexPath.row].atmDescription
            cell.lblCode.text = self.objAssetsListModel?.result.atmList[indexPath.row].stateCode
            cell.lblActionCount.text = "\(self.objAssetsListModel?.result.atmList[indexPath.row].actionCount ?? 0)"
            self.cell.imgAsset.sd_setImage(with: URL(string:(self.objAssetsListModel?.result.atmList[indexPath.row].atmMainImage)!), placeholderImage: UIImage(named: "image 16"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.AssetDetailsVC) as? AssetDetailsVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = self.objAssetsListModel {
            return self.objAssetsListModel?.result.atmList.count ?? 0
        }else{
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
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
            self.assetsListTblVw.reloadData()
        })
    }
    
    
}
