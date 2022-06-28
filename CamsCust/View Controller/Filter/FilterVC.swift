//  FilterVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 12/05/22.
import UIKit
import SwiftyJSON
class FilterVC: UIViewController {
    @IBOutlet weak var filterTblVw: UITableView!
    
    var cell1 : FilterCell = FilterCell()
    var cell2 : FilterCell2 = FilterCell2()
    var objFilterController = FilterController()
    
    var filterArr = ["Install Type","Survey Name","Image Name","Questions","Answer","State","City","Manufacturer","Model"]
    var param : [String:Any] = ["customer_id":"",
                                "service_id":"",
                                "question_id":"",
                                "state_code":"",
                                "manufacturer_id":""
    
    
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        objFilterController.delegate = self
        guard let customerID = UserDefaults.standard.value(forKey: Constant.user_defaults_value.customerID) as? Int else{return}
        param["customer_id"] = "\(customerID)"
         
        objFilterController.getFilterList(Param: param)
        
    }
    
    @IBAction func bttnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func bttnDone(_ sender: Any) {
    }
    
    func setupTableView(){
        filterTblVw.delegate = self
        filterTblVw.dataSource = self
        filterTblVw.separatorStyle = .none
    }
}
extension FilterVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            cell1 = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.FilterCell) as! FilterCell
            cell1.selectionStyle = .none
            cell1.layoutMargins = UIEdgeInsets.zero
            cell1.preservesSuperviewLayoutMargins = false
            cell1.backgroundColor = UIColor.clear
            return cell1
        }else{
            cell2 = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.FilterCell2) as! FilterCell2
            cell2.selectionStyle = .none
            cell2.layoutMargins = UIEdgeInsets.zero
            cell2.preservesSuperviewLayoutMargins = false
            cell2.backgroundColor = UIColor.clear
            cell2.lblTitle.text = filterArr[indexPath.row]
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.FilterSearchVC) as? FilterSearchVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return filterArr.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
}
extension FilterVC : FilterControllerDelegate{
    func FilterListFailedResponse(error: String) {
        DataManager.shared.hideLoader()
        DispatchQueue.main.async(execute: {() -> Void in
            Utility.alertWithOkMessage(title: Constant.variableText.appName, message: error, buttonText: Constant.variableText.ok, viewController: self, completionHandler: {})
        })
    }
    
    func FilterListSuccessResponse(dataArr: JSON, msg: String) {
        DataManager.shared.hideLoader()
        print("filter data ----->",dataArr)
        DispatchQueue.main.async(execute: {() -> Void in
           
            self.filterTblVw.reloadData()
            
        })
    }
    
    
}
