//
//  ForgotPasswordVC.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 09/05/22.
import UIKit
import SwiftyJSON
class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var forgotPasswordTblVw: UITableView!
    var forgotCell : ForgotPasswordCell = ForgotPasswordCell()
    var objForgotPasswordController = ForgotPasswordController()
    
    var forgotPasswordParam : [String:Any] = [Parameter.ForgotPasswordParam.email : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        objForgotPasswordController.delegate = self
    }
    
    func setupTableView(){
        self.forgotPasswordTblVw.delegate = self
        self.forgotPasswordTblVw.dataSource = self
        self.forgotPasswordTblVw.separatorStyle = .none
        self.forgotPasswordTblVw.tableHeaderView = UIView(frame: CGRect.zero)
        self.forgotPasswordTblVw.tableFooterView = UIView(frame: CGRect.zero)
    }
    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ForgotPasswordVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        forgotCell = tableView.dequeueReusableCell(withIdentifier: "ForgotPasswordCell") as! ForgotPasswordCell
        forgotCell.selectionStyle = .none
        forgotCell.bttnContinue.addTarget(self, action: #selector(forgotAction), for: .touchUpInside)
        return forgotCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.forgotPasswordTblVw.frame.size.height//UITableView.automaticDimension
    }
    @objc func forgotAction(){
        if isValidated(){
            forgotPasswordParam[Parameter.ForgotPasswordParam.email] = forgotCell.txtEmail.text
            objForgotPasswordController.forgotPassword(Param:forgotPasswordParam)
        }
       
    }
    func isValidated() -> Bool {
        if (forgotCell.txtEmail.text?.isEmpty)! || forgotCell.txtEmail.text == "" || forgotCell.txtEmail.text == " " {
            DispatchQueue.main.async{
                Utility.showAlert(message: Constant.Error_Message.Username_Error, vc:self )
            }
            return false
        }
        else
        {
            return true
        }
    }
    
}
extension ForgotPasswordVC:ForgotPasswordControllerDelegate{
    func forgotPasswordFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    
    func forgotPasswordSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: msg, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {
                self.navigationController?.popViewController(animated: true)
            })
        })
    }
    
    
}
