//
//  MyProfileCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 21/06/22.
//

import UIKit

class MyProfileCell: UITableViewCell {
    
    @IBOutlet weak var bttnChangePassword: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
