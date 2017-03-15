//
//  RoomTableViewCell.swift
//  AttenHome
//
//  Created by Attentec-62 on 23/03/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var powerConsumptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
