//
//  Radiator.swift
//  AttenHome
//
//  Created by Attentec-63 on 01/04/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import Foundation

class Radiator : Device{
    
    var temp: Int
    var temperature: [Double]
    
    required init(dict: NSDictionary){
        self.temp = dict["temp"] as! Int
        self.temperature = dict["temperature"] as! [Double]
        super.init(dict: dict)
    }
    
    override func toDictionary() -> NSMutableDictionary{
        let dictionary : NSMutableDictionary = super.toDictionary()
        dictionary["temp"] = self.temp
        dictionary["temperature"] = self.temperature
        return dictionary
    }
    
    
}