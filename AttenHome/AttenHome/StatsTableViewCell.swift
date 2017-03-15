//
//  StatsTableViewCell.swift
//  AttenHome
//
//  Created by Attentec-62 on 04/04/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import UIKit
import Charts

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expandImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
