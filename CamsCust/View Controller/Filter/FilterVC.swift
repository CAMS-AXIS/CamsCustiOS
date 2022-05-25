//  FilterVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 12/05/22.
import UIKit

class FilterVC: UIViewController {
    @IBOutlet weak var filterTblVw: UITableView!
    
    var cell1 : FilterCell = FilterCell()
    var cell2 : FilterCell2 = FilterCell2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

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
            return 2
        }else{
            return 8
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
}
