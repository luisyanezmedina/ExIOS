//
//  NombreCell.swift
//  ExIOS
//
//  Created by Jose Luis Yaenz on 24/01/22.
//

import UIKit

class NombreCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var NombreTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
