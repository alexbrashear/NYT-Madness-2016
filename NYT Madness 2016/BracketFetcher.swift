//
//  File.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

let URLString = "http://10.51.221.205:8080/bracket.json"

func fetchPlayers(completion:([Player?]) -> ()) {
    let URL = NSURL(string: URLString)
    let request = NSURLRequest(URL: URL!)

    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        let brackets = [Player?]()
        if let realData = data {
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(realData, options: NSJSONReadingOptions.AllowFragments) as! Array<AnyObject>
                for playerDictionary in object {
                    if let bracket = parsePlayer(playerDictionary) {
                        brackets.append(bracket)
                    }
                }

            }catch {
                
            }
        }
        completion(brackets)
        
        }.resume()
}