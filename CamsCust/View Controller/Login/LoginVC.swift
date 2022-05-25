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
                                    // Parameter.LoginParam.device_type : "",
                                    // Parameter.LoginParam.device_token : "",
                                     Parameter.LoginParam.password : ""
    
    ]
    var objLoginModel : LoginModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        objLoginController.delegate = self
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

        LoginParam[Parameter.LoginParam.email] = loginCell.txtUserName.text!
        LoginParam[Parameter.LoginParam.password] = loginCell.txtPassword.text!
        print(LoginParam)
        objLoginController.Login(Param:LoginParam)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.DashboardVC) as? DashboardVC
//        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
    
    @objc func forgotPasswordAction(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let forgotPasswordVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.ForgotPasswordVC) as? ForgotPasswordVC
        self.navigationController?.pushViewController(forgotPasswordVC!, animated: false)
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
                print(self.objLoginModel?.data?.role)
//                if let token = self.objLoginModel?.token
//                {
//                    UserDefaults.standard.set(token, forKey: Constant.user_defaults_value.token)
//                }
            })
        })
    }
    
   
    
    
    
}
