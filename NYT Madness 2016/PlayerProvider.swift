//
//  PlayerProvider.swift
//  NYT Madness 2016
//
//  Created by Adam Shott on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

protocol PlayerProviderDelegate {
    func playerProviderDidUpdate() -> ()
}

struct PlayerProvider {
    var players = [Player]()
    
    var delegate: PlayerProviderDelegate?
    
    init() {
        fetchPlayers { (fetchedPlayers:[Player?]) -> () in
            for player in fetchedPlayers where player != nil {
                self.players.append(player!)
            }
            
            if let realDelegate = self.delegate {
                realDelegate.playerProviderDidUpdate()
            }
        }
    }
    
    var playerCount: Int {
        return players.count
    }
    
    func player(row: Int) -> Player? {
        if (row < players.count) {
            return players[row]
        }
        return nil
    }
}