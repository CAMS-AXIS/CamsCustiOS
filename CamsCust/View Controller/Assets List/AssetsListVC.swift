//  AssetsListVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 12/05/22.
import UIKit
class AssetsListVC: UIViewController {
    @IBOutlet weak var assetsListTblVw: UITableView!
    
    var cell : AssetsListCell = AssetsListCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }
    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bttnFilterAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.FilterVC) as? FilterVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
    
    @IBAction func bttnLocation(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.MapVC) as? MapVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
    
    
    func setupTableView(){
        assetsListTblVw.delegate = self
        assetsListTblVw.dataSource = self
        assetsListTblVw.separatorStyle = .none
    }
}
extension AssetsListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.AssetsListCell) as! AssetsListCell
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.AssetDetailsVC) as? AssetDetailsVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
