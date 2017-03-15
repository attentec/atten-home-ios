//
//  APICalls.swift
//  AttenHome
//
//  Created by Attentec-62 on 01/04/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import Foundation

class APICalls{
    static func updateDevice(device: Device){
        let url = NSURL(string: "http://188.166.33.205/api/devices/\(device._id)") //Remember to put ATS exception if the URL is not https
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") //Optional
        request.HTTPMethod = "PUT"
        let session = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        do{
            let json = try NSJSONSerialization.dataWithJSONObject(device.toDictionary(), options: NSJSONWritingOptions.init(rawValue: 0))
            request.HTTPBody = json
        }catch let error as NSError{
            print(error)
            return
        }
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                //handle error
            }
            else {
                
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Parsed JSON: '\(jsonStr)'")
            } 
        }
        dataTask.resume()
    }
    
    static func getArray(type: String, params: [String: String], callback: ([NSDictionary]) ->()){
        var url = "http://188.166.33.205/api/\(type)?"
        for (key, value) in params{
            url += "\(key)=\(value)&"
        }
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            var result: [NSDictionary]!
            if error == nil && data != nil {
                do {
                    result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! [NSDictionary]
                    callback(result)
           
                } catch {
                    // Something went wrong
                }
            }
        }).resume()

    }
    
    static func getObject(type: String, id: String, callback: (NSDictionary) -> () ){
        let url = "http://188.166.33.205/api/\(type)/\(id)"
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            var result: NSDictionary!
            if error == nil && data != nil {
                do {
                    result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                    callback(result)
                    
                } catch {
                    // Something went wrong
                }
            }
        }).resume()

    }
    
}