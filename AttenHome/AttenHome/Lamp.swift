//
//  Lamp.swift
//  AttenHome
//
//  Created by Attentec-63 on 01/04/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import Foundation

class Lamp : Device{
    
    var dimmer: Int
    
    required init(dict: NSDictionary){
        self.dimmer = dict["dimmer"] as! Int
        super.init(dict: dict)
        
        
    }
    
    override func toDictionary() -> NSMutableDictionary{
        let dictionary : NSMutableDictionary = super.toDictionary()
        dictionary["dimmer"] = self.dimmer
        return dictionary
    }
}
