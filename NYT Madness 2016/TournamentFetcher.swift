//
//  TournamentFetcher.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

let tournamentSourceURL = "http://10.51.221.205:8080/tournament.json"

func fetchBrackets(completion:(Tournament?) -> ()) {
    let URL = NSURL(string: URLString)
    let request = NSURLRequest(URL: URL!)
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        let brackets = [Bracket?]()
        if let realData = data {
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(realData, options: NSJSONReadingOptions.AllowFragments) as! Array<AnyObject>
                for bracketDictionary in object {
                    if let bracket = parseBracket(bracketDictionary) {
                        brackets.append(bracket)
                    }
                }
                
            }catch {
                
            }
        }
        completion(brackets)
        
        }.resume()
}