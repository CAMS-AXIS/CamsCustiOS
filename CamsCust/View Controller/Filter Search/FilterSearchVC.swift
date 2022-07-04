//  FilterSearchVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 13/05/22.
import UIKit
class FilterSearchVC: UIViewController {
    @IBOutlet weak var filterSearchTblVw: UITableView!
    var cell : FilterSearchCell = FilterSearchCell()
    var selectedIndex = -1
    var selectedCat = ""
    var Arr = ["Exterior","Kiosk","ThroughTheWall","Interior","WalkUp","DriveUp","Freestanding"]
    var objFilterModel : FilterModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        print("=====+++",selectedCat)
    }
    
    func setupTableView(){
        filterSearchTblVw.delegate = self
        filterSearchTblVw.dataSource = self
        filterSearchTblVw.separatorStyle = .none
    }
    
    @IBAction func bttnBack(_ sender: Any) {
        if selectedCat == "Install Type"{
            DataManager.shared.param[Parameter.AssetsParam.install_type] = ""
        }
        else if selectedCat == "Survey Name"{
            DataManager.shared.survey_name = ""
            DataManager.shared.param[Parameter.AssetsParam.service_id] = ""
        }
        else if selectedCat == "Image Name"{
            DataManager.shared.param[Parameter.AssetsParam.image_id] = ""
        }
        else if selectedCat == "State"{
            DataManager.shared.param[Parameter.AssetsParam.state_code] = ""
        }
        else if selectedCat == "Manufacturer"{
            DataManager.shared.menu_name = ""
            DataManager.shared.param[Parameter.AssetsParam.atm_manu_id] = ""
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bttnDoneAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
extension FilterSearchVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.FilterSearchCell) as! FilterSearchCell
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        if selectedIndex == indexPath.row{
            cell.imgCheck.isHidden = false
            cell.imgCheck.image = #imageLiteral(resourceName: "Done")
        }else{
            cell.imgCheck.isHidden = true
        }
        
        if selectedCat == "Install Type"{
            cell.lblTitle.text = Arr[indexPath.row]
        }
        else if selectedCat == "Survey Name"{
            cell.lblTitle.text = self.objFilterModel?.result.serviceName[indexPath.row].serviceName
        }
        else if selectedCat == "Image Name"{
            cell.lblTitle.text = self.objFilterModel?.result.imageList[indexPath.row].imageName
        }
        else if selectedCat == "State"{
            cell.lblTitle.text = self.objFilterModel?.result.states[indexPath.row].stateID
        }
        else if selectedCat == "Manufacturer"{
            cell.lblTitle.text = self.objFilterModel?.result.manufacturerList[indexPath.row].manufacturerName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
                
        if selectedCat == "Install Type"{
            DataManager.shared.param[Parameter.AssetsParam.install_type] = Arr[indexPath.row]
        }
        else if selectedCat == "Survey Name"{
            DataManager.shared.survey_name = self.objFilterModel?.result.serviceName[indexPath.row].serviceName ?? ""
            DataManager.shared.param[Parameter.AssetsParam.service_id] = "\(self.objFilterModel?.result.serviceName[indexPath.row].serviceID ?? 0)"
        }
        else if selectedCat == "Image Name"{
            DataManager.shared.param[Parameter.AssetsParam.image_id] = self.objFilterModel?.result.imageList[indexPath.row].imageID
        }
        else if selectedCat == "State"{
            DataManager.shared.param[Parameter.AssetsParam.state_code] = self.objFilterModel?.result.states[indexPath.row].stateID
        }
        else if selectedCat == "Manufacturer"{
            DataManager.shared.menu_name = self.objFilterModel?.result.manufacturerList[indexPath.row].manufacturerName ?? ""
            
            DataManager.shared.param[Parameter.AssetsParam.atm_manu_id] = "\(self.objFilterModel?.result.manufacturerList[indexPath.row].manufacturerID ?? 0)"
        }
                
        self.filterSearchTblVw.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCat == "Install Type"{
            return Arr.count
        }
        else if selectedCat == "Survey Name"{
            return self.objFilterModel?.result.serviceName.count ?? 0
        }
        else if selectedCat == "Image Name"{
            return self.objFilterModel?.result.imageList.count ?? 0
        }
        else if selectedCat == "State"{
            return self.objFilterModel?.result.states.count ?? 0
        }
        else if selectedCat == "Manufacturer"{
            return self.objFilterModel?.result.manufacturerList.count ?? 0
        }else{
            return 0
        }
            
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
