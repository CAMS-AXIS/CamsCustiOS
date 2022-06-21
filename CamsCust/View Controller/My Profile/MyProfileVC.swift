//
//  MyProfileVC.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 21/06/22.
//

import UIKit
import SwiftyJSON

class MyProfileVC: UIViewController {

    @IBOutlet weak var profileTblVw: UITableView!
    var cell:MyProfileCell = MyProfileCell()
    var objMyProfileController = MyProfileController()
    var param : [String:Any] = [Parameter.DashboardParam.customer_id:""]
    var objMyProfileModel : MyProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        objMyProfileController.delegate = self
        setupTableView()
        guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
        param[Parameter.DashboardParam.customer_id] = "\(customerID)"
        objMyProfileController.getProfileDetails(Param: param)
    }
    

    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView(){
        profileTblVw.delegate = self
        profileTblVw.dataSource = self
        profileTblVw.separatorStyle = .none
    }
}
extension MyProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.MyProfileCell) as! MyProfileCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        if let _ = self.objMyProfileModel{
            cell.txtUserName.text = self.objMyProfileModel?.data.userName
            cell.txtEmail.text = self.objMyProfileModel?.data.email ?? "Null"
            cell.txtPassword.text = "*************"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
extension MyProfileVC:MyProfileControllerDelegate{
    func getProfileFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    
    func getProfileSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
            self.objMyProfileModel = MyProfileModel(Dict: dataArr)
            self.profileTblVw.reloadData()
        })
    }
    
    
}
