//
//  TournamentFetcherNew.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

let tournamentSourceURL = "http://10.51.221.205:8080/tournament.json"

func fetchTournament(completion:(Tournament?) -> ()) {
    let URL = NSURL(string: tournamentSourceURL)
    let request = NSURLRequest(URL: URL!)
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        var tournament: Tournament?
        if let realData = data {
            do {
                let tournamentDictionary = try NSJSONSerialization.JSONObjectWithData(realData, options: NSJSONReadingOptions.AllowFragments) as! Dictionary<String, [[String:Int]]>
                let tournamentParser = TournamentParser(teamProvider: TeamProvider())
                tournament = tournamentParser.parseTournament(tournamentDictionary)
            } catch {
                
            }
        }
        completion(tournament)
    }.resume()
}