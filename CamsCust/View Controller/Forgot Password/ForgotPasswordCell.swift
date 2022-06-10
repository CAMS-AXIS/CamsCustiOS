//
//  ForgotPasswordCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 09/05/22.
//

import UIKit

class ForgotPasswordCell: UITableViewCell {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var bttnContinue: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bttnContinue.clipsToBounds = true
        bttnContinue.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
