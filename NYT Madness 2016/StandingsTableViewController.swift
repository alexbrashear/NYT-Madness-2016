//
//  StandingsTableViewController.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import UIKit

class StandingsTableViewController: UITableViewController {
    var playerProvider = PlayerProvider()
    var teamProvider: TeamProvider?
    var tournament: Tournament?

    @IBOutlet weak var refreshBarButtonItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Standings"
        
        self.refreshData(nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playerProvider.playerCount
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rightDetail", forIndexPath: indexPath)

        // Configure the cell...
        let player = playerProvider.player(indexPath.row)
        
        cell.textLabel!.text = player!.name
        cell.detailTextLabel!.text = String(player!.pointTotal)

        return cell
    }
    
    func refreshData(completion: (() -> ())?) {
        fetchTeams { (fetchedTeams:[Team]?) -> () in
            var teamP = TeamProvider()
            teamP.teams = fetchedTeams!
            self.teamProvider = teamP
            
            let tournamentParser = TournamentParser(teamProvider: teamP)
            fetchTournament(tournamentParser, completion: { (tournament:Tournament?) -> () in
                
                if let fetchedTournament = tournament {
                    self.tournament = fetchedTournament
                    
                    fetchPlayers({ (fetchedPlayers:[Player?]) -> () in
                        var players = [Player]()
                        for player in fetchedPlayers where player != nil {
                            var player1 = player!
                            player1.pointTotal = calculatePoints(player!, tournament: self.tournament!)
                            players.append(player1)
                        }
                        players.sortInPlace({$0.pointTotal > $1.pointTotal})
                        if players.count > 0 {
                            self.playerProvider.players = players
                        }
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.tableView.reloadData()
                        })
                        if completion != nil {
                            completion!()
                        }
                    })
                }
                
            })
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {
        self.refreshBarButtonItem.enabled = false
        self.refreshData { () -> () in
            self.refreshBarButtonItem.enabled = true
        }
    }

}
