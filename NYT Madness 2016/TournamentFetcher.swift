//
//  TournamentFetcher.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

let tournamentSourceURL = "http://10.51.221.205:8080/tournament.json"

func fetchBrackets(completion:([Player?]) -> ()) {
    let URL = NSURL(string: URLString)
    let request = NSURLRequest(URL: URL!)
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        var players = [Player?]()
        if let realData = data {
            do {
                let tournament = Tournament()
                let playerParser = PlayerParser(tournament:tournament)
                let object = try NSJSONSerialization.JSONObjectWithData(realData, options: NSJSONReadingOptions.AllowFragments) as! Array<AnyObject>
                for playerDictionary in object {
                    players.append(playerParser.parsePlayer(playerDictionary as! Dictionary<String, AnyObject>))
                }
                
            }catch {
                
            }
        }
        completion(players)
        
        }.resume()
}