//
//  ActionItemCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 18/05/22.
//

import UIKit

class ActionItemCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblActionTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblActionDes: UILabel!
    @IBOutlet weak var imgActionItem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgActionItem.layer.cornerRadius = 5
        imgActionItem.layer.borderWidth = 0.3
        imgActionItem.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
