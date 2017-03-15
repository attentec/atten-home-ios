//
//  DeviceTableViewCell.swift
//  AttenHome
//
//  Created by Attentec-62 on 23/03/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
