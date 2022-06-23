//
//  ViewController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 09/05/22.
//

import UIKit
import SwiftyJSON
class LoginVC: UIViewController {
    
    
    @IBOutlet weak var loginTblVw: UITableView!
    
    var loginCell : LoginCell = LoginCell()
    var objLoginController = LoginController()
    var LoginParam : [String:Any] = [Parameter.LoginParam.email : "",
                                     Parameter.LoginParam.device_type : "iOS",
                                     Parameter.LoginParam.device_token : "",
                                     Parameter.LoginParam.password : ""
    
    ]
    var objLoginModel : LoginModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        objLoginController.delegate = self
        //self.loginCell.txtPassword.text = "123456"
    }
    func setupTableView(){
        self.loginTblVw.delegate = self
        self.loginTblVw.dataSource = self
        self.loginTblVw.separatorStyle = .none
        self.loginTblVw.tableHeaderView = UIView(frame: CGRect.zero)
        self.loginTblVw.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension LoginVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        loginCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.LoginCell) as! LoginCell
        loginCell.selectionStyle = .none
        loginCell.bttnLogin.addTarget(self, action: #selector(gotoNextPage), for: .touchUpInside)
        loginCell.bttnForgotPassword.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
        return loginCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.loginTblVw.frame.size.height//UITableView.automaticDimension
    }
    @objc func gotoNextPage(){
        if isValidated(){
            LoginParam[Parameter.LoginParam.email] = loginCell.txtUserName.text!
            LoginParam[Parameter.LoginParam.password] = loginCell.txtPassword.text!
            print(LoginParam)
            objLoginController.Login(Param:LoginParam)
        }
    }
    
    @objc func forgotPasswordAction(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let forgotPasswordVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.ForgotPasswordVC) as? ForgotPasswordVC
        self.navigationController?.pushViewController(forgotPasswordVC!, animated: false)
    }
    func isValidated() -> Bool {
        if (loginCell.txtUserName.text?.isEmpty)! || loginCell.txtUserName.text == "" || loginCell.txtUserName.text == " " {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.Username_Error, vc:self )
            }
            return false
        }
        else if (loginCell.txtPassword.text?.isEmpty)! || loginCell.txtPassword.text == "" || loginCell.txtPassword.text == " " {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.Password_Error, vc:self )
            }
            return false
        }
        else if ((loginCell.txtPassword.text?.count)! < 6)
        {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.PasswordCount_Error, vc: self)
            }
            return false
        }
            
        else
        {
            return true
        }
    }
    
}
extension LoginVC:LoginControllerDelegate{
    func loginFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    func loginSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: msg, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {
                self.objLoginModel = LoginModel(dataDict: dataArr)
                print("----===",self.objLoginModel?.data?.role)
                if self.objLoginModel?.data?.role == "Customers"{
                    
                    if let customerID = self.objLoginModel?.data?.customerID
                    {
                        UserDefaults.standard.set(customerID, forKey: Constant.user_defaults_value.customerID)
                    }
                    if let user_id = self.objLoginModel?.data?.user_id
                    {
                        UserDefaults.standard.set(user_id, forKey: Constant.user_defaults_value.user_id)
                    }
                    if let username = self.objLoginModel?.data?.username
                    {
                        UserDefaults.standard.set(username, forKey: Constant.user_defaults_value.username)
                    }
                    if let customerLogo = self.objLoginModel?.data?.customerLogo{
                        UserDefaults.standard.set(customerLogo, forKey: Constant.user_defaults_value.customerLogo)
                    }
                    
                   
                    UserDefaults.standard.set(self.loginCell.txtPassword.text, forKey: Constant.user_defaults_value.password)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.DashboardVC) as? DashboardVC
                    self.navigationController?.pushViewController(dashboardVC!, animated: false)
                }
            })
        })
    }
}
