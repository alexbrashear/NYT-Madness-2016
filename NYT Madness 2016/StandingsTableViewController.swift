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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTeams { (fetchedTeams:[Team]?) -> () in
            var teamP = TeamProvider()
            teamP.teams = fetchedTeams!
            self.teamProvider = teamP
            
            let tournamentParser = TournamentParser(teamProvider: teamP)
            fetchTournament(tournamentParser, completion: { (tournament:Tournament?) -> () in
                
                if let fetchedTournament = tournament {
                    self.tournament = fetchedTournament
                    
                    fetchPlayers({ (fetchedPlayers:[Player?]) -> () in
                        for player in fetchedPlayers where player != nil {
                            var player1 = player!
                            player1.pointTotal = calculatePoints(player!, tournament: self.tournament!)
                            self.playerProvider.players.append(player1)
                        }
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.tableView.reloadData()
                        })
                    })
                }
                
            })
        }

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
