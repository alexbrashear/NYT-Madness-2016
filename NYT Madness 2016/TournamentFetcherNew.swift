//
//  TournamentFetcherNew.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

let tournamentSourceURL = "http://10.51.221.205:8080/tournament.json"

func fetchTeams(completion:() -> ()) {
    let URL = NSURL(string: teamsSourceURL)
    let request = NSURLRequest(URL: URL!)
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        // declare something
        if let realData = data {
            do {
                let tournamentDictionary = try NSJSONSerialization.JSONObjectWithData(realData, options: NSJSONReadingOptions.AllowFragments) as! Dictionary<String, AnyObject>
                
            }catch {
                
            }
        }
        completion()
    }.resume()
}