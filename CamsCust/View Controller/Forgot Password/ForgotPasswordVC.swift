//
//  ForgotPasswordVC.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 09/05/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var forgotPasswordTblVw: UITableView!
    var forgotCell : ForgotPasswordCell = ForgotPasswordCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

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
       
        return forgotCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.forgotPasswordTblVw.frame.size.height//UITableView.automaticDimension
    }
   
    
}
