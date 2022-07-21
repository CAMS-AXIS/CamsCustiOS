//
//  AssetDetailsCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 18/05/22.
//

import UIKit

class AssetDetailsCell: UITableViewCell {
    @IBOutlet weak var AssetCollectionVw: UICollectionView!
    
    @IBOutlet weak var lblActionItemsCount: UILabel!
    @IBOutlet weak var bttnSurvey: UIButton!
    @IBOutlet weak var pageCount: UIPageControl!
    @IBOutlet weak var lblId: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDes: UILabel!
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
