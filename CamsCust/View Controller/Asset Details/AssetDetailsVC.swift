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
    var objAssetsDetailsModel : AssetsDetailsModel?
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
        cell.AssetCollectionVw.reloadData()
    }
    
    func setupServiceCollectionView(){
        serviceImgCell.serviceImgCollectionVw.delegate = self
        serviceImgCell.serviceImgCollectionVw.dataSource = self
        serviceImgCell.serviceImgCollectionVw.reloadData()
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
            
            if let _ = self.objAssetsDetailsModel?.data{
                cell.lblTitle.text = self.objAssetsDetailsModel?.data?.atmInfo.atmDescription
                cell.lblId.text = self.objAssetsDetailsModel?.data?.atmInfo.institutionAssignedID
                cell.lblDes.text = self.objAssetsDetailsModel?.data?.atmInfo.atmModel
                cell.lblAddress.text = self.objAssetsDetailsModel?.data?.atmInfo.comments
                cell.lblActionItemsCount.text = "Action Items (\(self.objAssetsDetailsModel?.data?.actionItems.count ?? 0))"
                cell.pageCount.numberOfPages = (self.objAssetsDetailsModel?.data?.atmImages.count)!
                cell.pageCount.currentPage = indexPath.row
            }
            
            setupCollectionView()
            return cell
        }else if indexPath.section == 1{
            itemCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.ActionItemCell) as! ActionItemCell
            
            if let _ = self.objAssetsDetailsModel?.data{
                if self.objAssetsDetailsModel?.data?.actionItems.count != 0{
                    itemCell.lblActionTitle.text = self.objAssetsDetailsModel?.data?.actionItems[indexPath.row].issueType
                    itemCell.lblActionDes.text = self.objAssetsDetailsModel?.data?.actionItems[indexPath.row].issueDescription
                    self.itemCell.imgActionItem.sd_setImage(with: URL(string:(self.objAssetsDetailsModel?.data?.actionItems[indexPath.row].imageURL)!), placeholderImage: UIImage(named: "image 12"))
                }
                
                
            }
            
            
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
            
            
            if let _ = self.objAssetsDetailsModel?.data{
            if self.objAssetsDetailsModel?.data?.services.count != 0{
                serviceListCell.lblTime.text = self.objAssetsDetailsModel?.data?.services[indexPath.row].time
                serviceListCell.lblDate.text = self.objAssetsDetailsModel?.data?.services[indexPath.row].date
                serviceListCell.lblTitle.text = self.objAssetsDetailsModel?.data?.services[indexPath.row].serviceName
            }
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
            if let _ = self.objAssetsDetailsModel?.data{
            if self.objAssetsDetailsModel?.data?.actionItems.count != 0{
                return (self.objAssetsDetailsModel?.data?.actionItems.count)!
            }else{
                return 0
            }
            }
            else
            {
                return 0
            }
        }else if section == 2
        {
            return 1
        }else{
            
            if let _ = self.objAssetsDetailsModel?.data{
            if self.objAssetsDetailsModel?.data?.services.count != 0{
                return (self.objAssetsDetailsModel?.data?.services.count)!
            }else{
                return 0
            }
            }
            else
            {
                return 0
            }

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
            if let _ = self.objAssetsDetailsModel?.data{
            if self.objAssetsDetailsModel?.data?.serviceImages.count != 0{
                return (self.objAssetsDetailsModel?.data?.serviceImages.count)!
            }else{
                return 0
            }
            }
            else
            {
                return 0
            }
        }else
        {
            if let _ = self.objAssetsDetailsModel?.data{
            if self.objAssetsDetailsModel?.data?.atmImages.count != 0{
                return (self.objAssetsDetailsModel?.data?.atmImages.count)!
            }else{
                return 0
            }
            }
            else
            {
                return 0
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == serviceImgCell.serviceImgCollectionVw{
            serviceCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.ServiceImgCollectionCell, for: indexPath) as! ServiceImgCollectionCell
            if let _ = self.objAssetsDetailsModel?.data{
                if self.objAssetsDetailsModel?.data?.serviceImages.count != 0{
                    self.serviceCollectionCell.imgService.sd_setImage(with: URL(string:(self.objAssetsDetailsModel?.data?.serviceImages[indexPath.row].imageURL)!), placeholderImage: UIImage(named: "image 12"))
                }
            }
            return serviceCollectionCell
        }else{
            collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.AssetsCollectionCell, for: indexPath) as! AssetsCollectionCell
            
            if let _ = self.objAssetsDetailsModel?.data{
                if self.objAssetsDetailsModel?.data?.atmImages.count != 0{
                    self.collectionCell.imgAtms.sd_setImage(with: URL(string:(self.objAssetsDetailsModel?.data?.atmImages[indexPath.row].imageURL)!), placeholderImage: UIImage(named: "image 16"))
                    
                }
            }
                        
            return collectionCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == serviceImgCell.serviceImgCollectionVw{
            let layout = CGSize(width:(self.serviceImgCell.serviceImgCollectionVw.frame.size.width - 10)/3,height: (self.serviceImgCell.serviceImgCollectionVw.frame.size.height)/3)
            return layout
        }else
        {
           // return CGSize(width: (cell.AssetCollectionVw.frame.width - 20), height:( cell.AssetCollectionVw.frame.height))
            
            return CGSize(width: 360, height:300)
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
            self.objAssetsDetailsModel = AssetsDetailsModel(objAssets: dataArr)
            print("=======>",self.objAssetsDetailsModel?.data?.actionItems.count)
            self.assetTblVw.reloadData()
        })
    }
}
