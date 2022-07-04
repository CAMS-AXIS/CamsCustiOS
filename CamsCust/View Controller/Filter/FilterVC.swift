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
    var objFilterModel : FilterModel?
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.filterTblVw.reloadData()
    }
    
    
    @IBAction func bttnCancel(_ sender: Any) {
        DataManager.shared.search_true = "no"
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func bttnDone(_ sender: Any) {
        DataManager.shared.search_true = "yes"
        self.navigationController?.popViewController(animated: true)
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
            cell1.bttnSwitch.addTarget(self, action: #selector(switchAction), for: .touchUpInside)
            return cell1
        }else{
            cell2 = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.FilterCell2) as! FilterCell2
            cell2.selectionStyle = .none
            cell2.layoutMargins = UIEdgeInsets.zero
            cell2.preservesSuperviewLayoutMargins = false
            cell2.backgroundColor = UIColor.clear
            cell2.lblTitle.text = filterArr[indexPath.row]
            if filterArr[indexPath.row] == "Install Type"{
                cell2.lblType.text = "\(DataManager.shared.param[Parameter.AssetsParam.install_type] ?? "All")"
            }
            else if filterArr[indexPath.row] == "Survey Name"{
                cell2.lblType.text = DataManager.shared.survey_name
            }
            else if filterArr[indexPath.row] == "Image Name"{
                cell2.lblType.text = "\(DataManager.shared.param[Parameter.AssetsParam.image_id] ?? "All")"
            }
            
            else if filterArr[indexPath.row] == "State"{
                cell2.lblType.text = "\(DataManager.shared.param[Parameter.AssetsParam.state_code] ?? "All")"
            }
            else if filterArr[indexPath.row] == "Manufacturer"{
                cell2.lblType.text = DataManager.shared.menu_name
            }
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.FilterSearchVC) as? FilterSearchVC
        
        if filterArr[indexPath.row] == "Install Type"{
            dashboardVC?.selectedCat = filterArr[indexPath.row]
        }
        else if filterArr[indexPath.row] == "Survey Name"{
            dashboardVC?.selectedCat = filterArr[indexPath.row]
            dashboardVC?.objFilterModel = self.objFilterModel
        }
        else if filterArr[indexPath.row] == "Image Name"{
            dashboardVC?.selectedCat = filterArr[indexPath.row]
            dashboardVC?.objFilterModel = self.objFilterModel
        }
        
        else if filterArr[indexPath.row] == "State"{
            dashboardVC?.selectedCat = filterArr[indexPath.row]
            dashboardVC?.objFilterModel = self.objFilterModel
        }
        else if filterArr[indexPath.row] == "Manufacturer"{
            dashboardVC?.selectedCat = filterArr[indexPath.row]
            dashboardVC?.objFilterModel = self.objFilterModel
        }
                
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
    
    @objc func switchAction(){
        if cell1.bttnSwitch.isOn{
            print("ON")
        }else{
            print("OFF")
        }
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
            self.objFilterModel = FilterModel(MyData: dataArr)
            self.filterTblVw.reloadData()
            
        })
    }
    
    
}
