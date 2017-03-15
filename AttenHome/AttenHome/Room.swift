//
//  Room.swift
//  AttenHome
//
//  Created by Attentec-62 on 23/03/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import Foundation

class Room : BaseModel{
    //MARK: Properties
    
    var houseId: String
    var temperature: [Double]
    //MARK: Initialization
    
    required init(dict: NSDictionary){
        self.houseId = dict["houseId"] as! String
        self.temperature = dict["temperature"] as! [Double]
        super.init(dict: dict)
    }
    
}
