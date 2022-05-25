//
//  SelectSurveyVC.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 18/05/22.
//

import UIKit

class SelectSurveyVC: UIViewController {

    @IBOutlet weak var surveyTblVw: UITableView!
    var cell : SelectSurveyCell = SelectSurveyCell()
    var selectedIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
   
    
    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView(){
        surveyTblVw.delegate = self
        surveyTblVw.dataSource = self
        surveyTblVw.separatorStyle = .none
    }

    @IBAction func bttnBeginSurveyAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.ReviewSurveyVC) as? ReviewSurveyVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
    
}
extension SelectSurveyVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.SelectSurveyCell) as! SelectSurveyCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        if selectedIndex == indexPath.row{
            cell.imgCheck.isHidden = false
            cell.lblTitle.textColor = UIColor.systemBlue
            cell.viewContent.backgroundColor = UIColor.systemGray.withAlphaComponent(0.4)
            cell.imgCheck.image = #imageLiteral(resourceName: "Done")
        }else{
            cell.imgCheck.isHidden = true
            cell.lblTitle.textColor = UIColor.black
            cell.viewContent.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.surveyTblVw.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
