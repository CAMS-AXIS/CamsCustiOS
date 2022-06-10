//
//  DashboardCollectionCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 10/05/22.
//

import UIKit

class DashboardCollectionCell: UICollectionViewCell {
    @IBOutlet weak var chartView: CircularProgressView!
    
    
    @IBOutlet weak var label: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        label.textColor = UIColor.black
//        label.font = UIFont(name: "Inter-Bold", size: 18.0)
//        label.numberOfLines = 0
//        label.frame = CGRect(x: (self.chartView.bounds.size.width/2) - 25,y: (self.chartView.bounds.size.height/2) - 5,width: self.chartView.bounds.size.width, height: 60)
//        label.textAlignment = .center
//        label.sizeToFit()
//       chartView.addSubview(label)
    }
    

}
