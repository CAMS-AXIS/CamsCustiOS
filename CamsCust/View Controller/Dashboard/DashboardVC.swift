//  DashboardVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 09/05/22.
import UIKit
import SwiftyJSON
import SDWebImage
class DashboardVC: BaseViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var bttnMenu: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAssetCount: UILabel!
    
    @IBOutlet weak var lblActionItemsCount: UILabel!

    @IBOutlet weak var imgLogo: UIImageView!
    
    var collectionCell : DashboardCollectionCell = DashboardCollectionCell()
    var objDashboardController = DashboardController()
    var param : [String:Any] = [Parameter.DashboardParam.customer_id:""]
    var objDashboardModel : DashboardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objDashboardController.delegate = self
        addSlideMenuButton(btn: bttnMenu)
        setupCollectionVw()
        guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
        
        guard let username = UserDefaults.standard.value(forKey: Constant.user_defaults_value.username) as? String else{return}

        guard let logo = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerLogo) as? String else{return}
        self.imgLogo.sd_setImage(with: URL(string: logo), placeholderImage: UIImage(named: ""))

        
        self.lblName.text = "Welcome, \(username)"
        param[Parameter.DashboardParam.customer_id] = "\(customerID)"
        print(param)
        objDashboardController.DashboardDetails(Param: param)
    }
    func setupCollectionVw(){
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.backgroundColor = UIColor.clear
        myCollectionView.reloadData()
    }
    
    @IBAction func bttnMenuAction(_ sender: UIButton) {
       
    }
    
    @IBAction func bttnAssetsAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.AssetsListVC) as? AssetsListVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
        
    }
    
}
extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = self.objDashboardModel?.data?.tiles{
            return (self.objDashboardModel?.data?.tiles.count)!
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.DashboardCollectionCell, for: indexPath) as! DashboardCollectionCell
        if let _ = self.objDashboardModel?.data?.tiles{
            collectionCell.chartView.progressAnimation(Float(self.objDashboardModel?.data?.tiles[indexPath.row].kpiPercentage ?? 0.0))
        
            
            collectionCell.chartView.customStrokeColor = UIColor(hexString:(self.objDashboardModel?.data?.tiles[indexPath.row].colorCode)!).cgColor
            
            let myDouble = self.objDashboardModel?.data?.tiles[indexPath.row].kpiPercentage ?? 0.0
            collectionCell.label.textColor = UIColor.black
            collectionCell.label.font = UIFont(name: "Inter-Bold", size: 15.0)
            collectionCell.label.numberOfLines = 0
            
            let string: NSMutableAttributedString = NSMutableAttributedString(string: "\(self.objDashboardModel?.data?.tiles[indexPath.row].issueCategory ?? "") \n\n \(String(format: "%.2f", myDouble))%")
            string.setColor(color: UIColor(hexString:(self.objDashboardModel?.data?.tiles[indexPath.row].colorCode)!), forText: (self.objDashboardModel?.data?.tiles[indexPath.row].issueCategory ?? ""))
            string.setColor(color: UIColor.black, forText: "\(myDouble)%")
            collectionCell.label.attributedText = string
            
            collectionCell.label.textAlignment = .center
            collectionCell.label.sizeToFit()
            
            collectionCell.chartView.layoutSubviews()
            collectionCell.chartView.addSubview(collectionCell.label)
                  
            self.lblAssetCount.text = "\(self.objDashboardModel?.data?.assetCount ?? 0)"
            self.lblActionItemsCount.text = "\(self.objDashboardModel?.data?.actionItems ?? 0)"
        }
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: ((myCollectionView.frame.width - 80) / 2), height:( (myCollectionView.frame.height - 160) / 2))
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
        

}
extension DashboardVC:DashboardControllerDelegate{
    func dashboardFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    
    func dashboardSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
            self.objDashboardModel = DashboardModel(dataDict: dataArr)
            print("=======++++",self.objDashboardModel?.data?.tiles.count)
            self.myCollectionView.reloadData()
        })
    }
    
  
   
}
