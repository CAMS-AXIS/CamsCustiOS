//
//  AssetsListCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 12/05/22.
//

import UIKit

class AssetsListCell: UITableViewCell {
    @IBOutlet weak var imgAsset: UIImageView!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblActionCount: UILabel!
    
    @IBOutlet weak var lblCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
