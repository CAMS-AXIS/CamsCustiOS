//
//  ReviewSurveyVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 19/05/22.
import UIKit

class ReviewSurveyVC: UIViewController {
    @IBOutlet weak var reviewTblVw: UITableView!
    var cell : ReviewSurveyCell = ReviewSurveyCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    @IBAction func bttnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView(){
        reviewTblVw.delegate = self
        reviewTblVw.dataSource = self
        reviewTblVw.separatorStyle = .none
    }

}
extension ReviewSurveyVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.ReviewSurveyCell) as! ReviewSurveyCell
        cell.selectionStyle = .none
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
