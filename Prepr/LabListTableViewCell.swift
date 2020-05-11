//
//  LabListTableViewCell.swift
//  Prepr
//
//  Created by Shyam on 10/05/20.
//  Copyright © 2020 SOLS247. All rights reserved.
//

import UIKit

class LabListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
