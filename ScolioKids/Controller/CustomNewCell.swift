//
//  CustomNewCell.swift
//  ScolioKids
//
//  Created by Anne Victoria Batista Auzier on 03/06/22.
//

import UIKit

class CustomNewCell: UITableViewCell {

    @IBOutlet weak var textCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

