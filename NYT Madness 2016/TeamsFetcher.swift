//
//  TeamsFetcher.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

let tournamentSourceURL = "http://10.51.221.205:8080/tournament.json"
let teamsSourceURL = "http://10.51.221.205:8080/teams.json"

func fetchTeams(completion:([Team]?) -> ()) {
    let URL = NSURL(string: teamsSourceURL)
    let request = NSURLRequest(URL: URL!)
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        var teams = [Team]()
        if let realData = data {
            do {
                let teamsDictionary = try NSJSONSerialization.JSONObjectWithData(realData, options: NSJSONReadingOptions.AllowFragments) as! Dictionary<String, Int>
                let teamParser = TeamParser()
                teams = teamParser.parseTeams(teamsDictionary)
                
            }catch {
                
            }
        }
        completion(teams)
        
        }.resume()
}