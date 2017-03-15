//
//  House.swift
//  AttenHome
//
//  Created by Attentec-62 on 04/04/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import Foundation

class House : BaseModel{
    //MARK: Properties
    var temperature: [Double]
    //MARK: Initialization
    
    required init(dict: NSDictionary){
        self.temperature = dict["temperature"] as! [Double]
        super.init(dict: dict)
    }
    
}
