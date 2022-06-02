//
//  CustomCell.swift
//  ScolioKids
//
//  Created by Anne Victoria Batista Auzier on 02/06/22.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var assetsImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ExerciciosEspView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
