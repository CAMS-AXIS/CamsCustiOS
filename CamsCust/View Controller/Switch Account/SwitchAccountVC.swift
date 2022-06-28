//
//  SwitchAccountVC.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 11/05/22.
//

import UIKit
import SwiftyJSON

class SwitchAccountVC: BaseViewController {
    @IBOutlet weak var accountTblVw: UITableView!
    var cell : SwitchAccountCell = SwitchAccountCell()
    var selectedIndex = -1
    var objSwitchAccountController = SwitchAccountController()
    var param : [String:Any] = ["user_id":""]
    var objSwitchAccountModel : SwitchAccountModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        objSwitchAccountController.delegate = self
        guard let user_id = UserDefaults.standard.value(forKey: Constant.user_defaults_value.user_id) as? String else{return}
        param["user_id"] = user_id
        objSwitchAccountController.getAccountList(Param:param)
    }
    
    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView(){
        accountTblVw.delegate = self
        accountTblVw.dataSource = self
        accountTblVw.separatorStyle = .none
    }

}
extension SwitchAccountVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.SwitchAccountCell) as! SwitchAccountCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        if let _ = self.objSwitchAccountModel{
            cell.lblTitle.text = self.objSwitchAccountModel?.data[indexPath.row].customerName
        }
        
        if selectedIndex == indexPath.row{
            cell.imgCheck.isHidden = false
            cell.lblTitle.textColor = UIColor.systemBlue
            cell.viewContent.backgroundColor = UIColor.systemGray.withAlphaComponent(0.4)
            cell.imgCheck.image = #imageLiteral(resourceName: "Done")
        }else{
            cell.imgCheck.isHidden = true
            cell.lblTitle.textColor = UIColor.black
            cell.viewContent.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.accountTblVw.reloadData()
        
        let refreshAlert = UIAlertController(title: "", message: "Do you want to switch your Account?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
            if let _ = self.objSwitchAccountModel{
                if let customerID = self.objSwitchAccountModel?.data[indexPath.row].customerID
                {
                    UserDefaults.standard.set(customerID, forKey: Constant.user_defaults_value.customerID)
                }
                if let customerID = self.objSwitchAccountModel?.data[indexPath.row].customerName
                {
                    UserDefaults.standard.set(customerID, forKey: Constant.user_defaults_value.username)
                }
                if let customerLogo = self.objSwitchAccountModel?.data[indexPath.row].CustomerLogo{
                    UserDefaults.standard.set(customerLogo, forKey: Constant.user_defaults_value.customerLogo)
                }
                self.cell.lblTitle.text = self.objSwitchAccountModel?.data[indexPath.row].customerName
                
            }
            self.navigationController?.popViewController(animated: true)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
            self.selectedIndex = -1
            self.accountTblVw.reloadData()
        }))

        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
        
        
        
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = self.objSwitchAccountModel{
            return self.objSwitchAccountModel?.data.count ?? 0
        }else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
extension SwitchAccountVC:SwitchAccountControllerDelegate{
    func getAccountListFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    
    func getAccountListSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
            self.objSwitchAccountModel = SwitchAccountModel(MyDict: dataArr)
            self.accountTblVw.reloadData()
        })
    }    
}
