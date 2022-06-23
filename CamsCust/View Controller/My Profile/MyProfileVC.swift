//  MyProfileVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 21/06/22.
import UIKit
import SwiftyJSON
class MyProfileVC: UIViewController {
    
    @IBOutlet weak var profileTblVw: UITableView!
    
    var cell:MyProfileCell = MyProfileCell()
    var passwordCell : MyProfileCell2 = MyProfileCell2()
    
    var objMyProfileController = MyProfileController()
    var param : [String:Any] = [Parameter.DashboardParam.customer_id:""]
    var objMyProfileModel : MyProfileModel?
    var selectPassword = ""
    var myPassword = "**********"
    override func viewDidLoad() {
        super.viewDidLoad()
        objMyProfileController.delegate = self
        setupTableView()
        guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
        
        guard let password = UserDefaults.standard.value(forKey: Constant.user_defaults_value.password) as? String else{return}
        self.myPassword = password
        print(self.myPassword)
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
        
        if self.selectPassword == "selected"{
            if indexPath.section == 0{
                cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.MyProfileCell) as! MyProfileCell
                cell.layoutMargins = UIEdgeInsets.zero
                cell.preservesSuperviewLayoutMargins = false
                cell.backgroundColor = UIColor.clear
                cell.bttnChangePassword.addTarget(self, action: #selector(showChangePass), for: .touchUpInside)
                        
                if let _ = self.objMyProfileModel{
                    cell.txtUserName.text = self.objMyProfileModel?.data.userName
                    cell.txtEmail.text = self.objMyProfileModel?.data.email ?? "Null"
                   
                    cell.txtPassword.text = self.myPassword
                }
                
                return cell
            }
            else{
                passwordCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.MyProfileCell2) as! MyProfileCell2
                passwordCell.layoutMargins = UIEdgeInsets.zero
                passwordCell.preservesSuperviewLayoutMargins = false
                passwordCell.backgroundColor = UIColor.clear
                passwordCell.bttnSave.addTarget(self, action: #selector(savePassword), for: .touchUpInside)
                return passwordCell
            }
            
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.MyProfileCell) as! MyProfileCell
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clear
            cell.bttnChangePassword.addTarget(self, action: #selector(showChangePass), for: .touchUpInside)
                    
            if let _ = self.objMyProfileModel{
                cell.txtUserName.text = self.objMyProfileModel?.data.userName
                cell.txtEmail.text = self.objMyProfileModel?.data.email ?? "Null"
                cell.txtPassword.text = self.myPassword
            }
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.selectPassword == "selected"{
            return 2
        }else{
        return 1
        }
    }
    @objc func showChangePass(){
        self.selectPassword = "selected"
        self.profileTblVw.reloadData()
        
    }
    @objc func savePassword(){
        if isValidated(){
            print("yes")
        }
    }
    
    func isValidated() -> Bool {
        if (passwordCell.txtOldPass.text?.isEmpty)! || passwordCell.txtOldPass.text == "" || passwordCell.txtOldPass.text == " " {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.Current_Password_Error, vc:self )
            }
            return false
        }
        else if self.myPassword != passwordCell.txtOldPass.text {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.Current_password_Error, vc:self )
            }
            return false
        }
        else if (passwordCell.txtNewPass.text?.isEmpty)! || passwordCell.txtNewPass.text == "" || passwordCell.txtNewPass.text == " " {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.New_Password_Error, vc:self )
            }
            return false
        }
        else if ((passwordCell.txtNewPass.text?.count)! < 6)
        {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.PasswordCount_Error, vc: self)
            }
            return false
        }
        else if (passwordCell.txtConfirmPass.text?.isEmpty)! || passwordCell.txtConfirmPass.text == "" || passwordCell.txtConfirmPass.text == " " {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.Confirm_Password_Error, vc:self )
            }
            return false
        }
        else if passwordCell.txtNewPass.text != passwordCell.txtConfirmPass.text {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.Same_Password_Error, vc:self )
            }
            return false
        }
        else
        {
            return true
        }
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
