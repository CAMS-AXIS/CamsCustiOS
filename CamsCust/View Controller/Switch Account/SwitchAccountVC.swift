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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        objSwitchAccountController.delegate = self
        guard let user_id = UserDefaults.standard.value(forKey: Constant.user_defaults_value.user_id) as? Int else{return}
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
            
            self.accountTblVw.reloadData()
        })
    }
    
    
}
