//
//  LoginCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 09/05/22.
//

import UIKit

class LoginCell: UITableViewCell {

    @IBOutlet weak var bttnLogin: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bttnLogin.clipsToBounds = true
        bttnLogin.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
