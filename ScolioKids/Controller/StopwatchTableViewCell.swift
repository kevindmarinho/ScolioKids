//
//  StopwatchTableViewCell.swift
//  ScolioKids
//
//  Created by Dessana Santos on 17/06/22.
//

import UIKit

class StopwatchTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

//    @IBOutlet weak var pickerVie

    @IBOutlet weak var pickerViewNumbers: UIPickerView!
    var pickerNumbers = Array(0...30)

    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        pickerViewNumbers.delegate = self
//        pickerViewNumbers.dataSource = self
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerNumbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let pickerNumber = "\(pickerNumbers[row])"
        
        return pickerNumber
    }

}
