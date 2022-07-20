//  ProductDetailsVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 16/05/22.
import UIKit
import SwiftyJSON
class AssetDetailsVC: UIViewController {
    
    @IBOutlet weak var assetTblVw: UITableView!
    var cell : AssetDetailsCell = AssetDetailsCell()
    var itemCell : ActionItemCell = ActionItemCell()
    var serviceImgCell : ServiceImgCell = ServiceImgCell()
    var collectionCell : AssetsCollectionCell = AssetsCollectionCell()
    var serviceCollectionCell : ServiceImgCollectionCell = ServiceImgCollectionCell()
    var serviceListCell : ServiceListCell = ServiceListCell()
    
    var objAssetsDetailsController = AssetsDetailsController()
    var asset_id = String()
    var param : [String:Any] = ["ATMID" : ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        objAssetsDetailsController.delegate = self
        print("asset_id is : ",asset_id)
        param["ATMID"] = self.asset_id
        objAssetsDetailsController.getAssetsDetails(Param: param)

    }
    
    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setupTableView(){
        assetTblVw.delegate = self
        assetTblVw.dataSource = self
        assetTblVw.separatorStyle = .none
    }
    func setupCollectionView(){
        cell.AssetCollectionVw.delegate = self
        cell.AssetCollectionVw.dataSource = self
    }

    func setupServiceCollectionView(){
        serviceImgCell.serviceImgCollectionVw.delegate = self
        serviceImgCell.serviceImgCollectionVw.dataSource = self
    }

}
extension AssetDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.AssetDetailsCell) as! AssetDetailsCell
            cell.selectionStyle = .none
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clear
            cell.bttnSurvey.addTarget(self, action: #selector(gotoSurveyPage), for: .touchUpInside)
            setupCollectionView()
            return cell
        }else if indexPath.section == 1{
            itemCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.ActionItemCell) as! ActionItemCell
            itemCell.selectionStyle = .none
            itemCell.layoutMargins = UIEdgeInsets.zero
            itemCell.preservesSuperviewLayoutMargins = false
            itemCell.backgroundColor = UIColor.clear
            return itemCell
        }else if indexPath.section == 2{
            serviceImgCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.ServiceImgCell) as! ServiceImgCell
            serviceImgCell.selectionStyle = .none
            serviceImgCell.layoutMargins = UIEdgeInsets.zero
            serviceImgCell.preservesSuperviewLayoutMargins = false
            serviceImgCell.backgroundColor = UIColor.clear
            setupServiceCollectionView()
            return serviceImgCell
        }else{
            serviceListCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.ServiceListCell) as! ServiceListCell
            serviceListCell.selectionStyle = .none
            serviceListCell.layoutMargins = UIEdgeInsets.zero
            serviceListCell.preservesSuperviewLayoutMargins = false
            serviceListCell.backgroundColor = UIColor.clear
            if indexPath.row == 0{
                serviceListCell.lblServiceTag.isHidden = false
            }else{
                serviceListCell.lblServiceTag.isHidden = true
            }
            return serviceListCell
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else if section == 1
        {
        return 2
        }else if section == 2
        {
            return 1
        }else{
            return 5
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4;
    }
    @objc func gotoSurveyPage(){
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.SelectSurveyVC) as? SelectSurveyVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
       
    }
}
extension AssetDetailsVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == serviceImgCell.serviceImgCollectionVw{
            return 12
        }else
        {
            return 5
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == serviceImgCell.serviceImgCollectionVw{
            serviceCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.ServiceImgCollectionCell, for: indexPath) as! ServiceImgCollectionCell
            return serviceCollectionCell
        }else{
            collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.AssetsCollectionCell, for: indexPath) as! AssetsCollectionCell
            return collectionCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == serviceImgCell.serviceImgCollectionVw{
            let layout = CGSize(width:(self.serviceImgCell.serviceImgCollectionVw.frame.size.width - 10)/3,height: (self.serviceImgCell.serviceImgCollectionVw.frame.size.height)/3)
            return layout
        }else
        {
            return CGSize(width: (cell.AssetCollectionVw.frame.width), height:( cell.AssetCollectionVw.frame.height))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
        
}
extension AssetDetailsVC:AssetsDetailsControllerDelegate{
    func AssetsDetailsFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    
    func AssetsDetailsSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.assetTblVw.reloadData()
            
        })
    }
    
    
}
