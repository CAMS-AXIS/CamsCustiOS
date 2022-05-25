//
//  SwitchAccountCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 11/05/22.
//

import UIKit

class SwitchAccountCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
