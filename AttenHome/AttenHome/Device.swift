//
//  Device.swift
//  AttenHome
//
//  Created by Attentec-62 on 23/03/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import Foundation

class Device : BaseModel{
    //MARK: Properties
    
    var roomId: String
    var powerConsumption: Double
    var powered: Bool
    var __t: String
    
    //MARK: Initialization
    
    required init(dict: NSDictionary){
        self.roomId = dict["roomId"] as! String
        self.powerConsumption = dict["powerConsumption"] as! Double
        self.powered = dict["powered"] as! Bool
        self.__t = dict["__t"] as! String
        super.init(dict: dict)
    }
    
    override func toDictionary() -> NSMutableDictionary{
        let dictionary : NSMutableDictionary = super.toDictionary()
        dictionary["roomId"] = self.roomId
        dictionary["powerConsumption"] = self.powerConsumption
        dictionary["powered"] = self.powered
        dictionary["__t"] = self.__t
        dictionary["type"] = self.__t
        return dictionary
    }
    
}
