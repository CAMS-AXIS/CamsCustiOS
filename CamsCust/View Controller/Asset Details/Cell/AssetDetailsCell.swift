//
//  AssetDetailsCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 18/05/22.
//

import UIKit

class AssetDetailsCell: UITableViewCell {
    @IBOutlet weak var AssetCollectionVw: UICollectionView!
    
    @IBOutlet weak var bttnSurvey: UIButton!
    @IBOutlet weak var pageCount: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
