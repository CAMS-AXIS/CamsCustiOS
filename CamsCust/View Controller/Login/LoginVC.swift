//
//  ViewController.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 09/05/22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var loginTblVw: UITableView!
    
    var loginCell : LoginCell = LoginCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        loginCell = tableView.dequeueReusableCell(withIdentifier: "LoginCell") as! LoginCell
        loginCell.selectionStyle = .none
        return loginCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.loginTblVw.frame.size.height//UITableView.automaticDimension
    }
    
}
