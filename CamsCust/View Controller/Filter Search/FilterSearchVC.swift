//
//  FilterSearchVC.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 13/05/22.
//

import UIKit

class FilterSearchVC: UIViewController {

    @IBOutlet weak var filterSearchTblVw: UITableView!
    
    
    var cell : FilterSearchCell = FilterSearchCell()
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        filterSearchTblVw.delegate = self
        filterSearchTblVw.dataSource = self
        filterSearchTblVw.separatorStyle = .none
    }
    
    @IBAction func bttnBack(_ sender: Any) {
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
        
        
            return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.filterSearchTblVw.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 15
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
