//
//  ProductDetailsVC.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 16/05/22.
//

import UIKit

class AssetDetailsVC: UIViewController {
    
    @IBOutlet weak var assetTblVw: UITableView!
    var cell : AssetDetailsCell = AssetDetailsCell()
    var itemCell : ActionItemCell = ActionItemCell()
    var collectionCell : AssetsCollectionCell = AssetsCollectionCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }
    
    @IBAction func bttnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setupTableView(){
        assetTblVw.delegate = self
        assetTblVw.dataSource = self
        assetTblVw.separatorStyle = .none
    }
    func setupCollectionView(){
        cell.AssetCollectionVw.delegate = self
        cell.AssetCollectionVw.dataSource = self
    }

}
extension AssetDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.AssetDetailsCell) as! AssetDetailsCell
            cell.selectionStyle = .none
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clear
            cell.bttnSurvey.addTarget(self, action: #selector(gotoSurveyPage), for: .touchUpInside)
            setupCollectionView()
            return cell
        }else{
            itemCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.ActionItemCell) as! ActionItemCell
            itemCell.selectionStyle = .none
            itemCell.layoutMargins = UIEdgeInsets.zero
            itemCell.preservesSuperviewLayoutMargins = false
            itemCell.backgroundColor = UIColor.clear
            return itemCell
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
        return 2
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2;
    }
    @objc func gotoSurveyPage(){
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.SelectSurveyVC) as? SelectSurveyVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
       
    }
}
extension AssetDetailsVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.AssetsCollectionCell, for: indexPath) as! AssetsCollectionCell
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: (cell.AssetCollectionVw.frame.width), height:( cell.AssetCollectionVw.frame.height))
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
        
}
