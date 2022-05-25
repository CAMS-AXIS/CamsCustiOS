//
//  ReviewSurveyCell.swift
//  CamsCust
//
//  Created by Dipika Ghosh on 24/05/22.
//

import UIKit

class ReviewSurveyCell: UITableViewCell {
    @IBOutlet weak var viewContent: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContent.clipsToBounds = true
        viewContent.layer.borderWidth = 0.4
        viewContent.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
