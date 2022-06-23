//
//  MyProfileCell2.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 21/06/22.
//

import UIKit

class MyProfileCell2: UITableViewCell {
    @IBOutlet weak var txtOldPass: UITextField!
    
    @IBOutlet weak var txtNewPass: UITextField!
    
    @IBOutlet weak var bttnSave: UIButton!
    @IBOutlet weak var txtConfirmPass: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
