//  DashboardVC.swift
//  CamsCust
//  Created by Dipika Ghosh on 09/05/22.
import UIKit

class DashboardVC: BaseViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var bttnMenu: UIButton!
    
    var collectionCell : DashboardCollectionCell = DashboardCollectionCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton(btn: bttnMenu)
        setupCollectionVw()
        
    }
    func setupCollectionVw(){
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.backgroundColor = UIColor.clear
        myCollectionView.reloadData()
    }
    
    @IBAction func bttnMenuAction(_ sender: UIButton) {
       
    }
    
    @IBAction func bttnAssetsAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.AssetsListVC) as? AssetsListVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
        
    }
    
}
extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.DashboardCollectionCell, for: indexPath) as! DashboardCollectionCell
        
        collectionCell.chartView.progressAnimation(25.0)
        
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: ((myCollectionView.frame.width - 80) / 2), height:( (myCollectionView.frame.height - 160) / 2))
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
        

}
