//
//  BaseModel.swift
//  AttenHome
//
//  Created by Attentec-62 on 23/03/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import Foundation

class BaseModel{
    //MARK: Properties
    var _id: String
    var name: String
    var powerData: [Double]

    
    required init(dict: NSDictionary){
        self.name = dict["name"] as! String
        self.powerData = dict["powerData"] as! [Double]
        self._id = dict["_id"] as! String
    }
    
    func toDictionary() -> NSMutableDictionary{
        let dictionary: NSMutableDictionary = ["name": self.name, "_id": self._id, "powerData": self.powerData]
        return dictionary
    }

    
    
}
