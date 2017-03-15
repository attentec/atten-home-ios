//
//  RoomTableViewController.swift
//  AttenHome
//
//  Created by Attentec-62 on 23/03/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import UIKit

class RoomTableViewController: UITableViewController {

    // MARK: Properties
    var rooms = [Room]()
    var houseId = "56e7e5e8c798cfaf310641b7"
    var house : House?

    override func viewDidLoad() {
        super.viewDidLoad()
        let bi = UIBarButtonItem(image: UIImage(named: "Attentec.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        tabBarController?.navigationItem.rightBarButtonItem = bi
    }
    
    override func viewWillAppear(true:Bool) {
        print("RoomList loaded " + String(NSDate().timeIntervalSince1970));
        super.viewWillAppear(true)
        loadData()
    }
    
    func loadData(){
        let params = ["houseId":houseId]
        APICalls.getArray("rooms", params: params, callback: tableRefresh)
        

    }
    
    func tableRefresh(result: [NSDictionary])
    {
        var data = [Room]()
        for dict in result{
            data.append(Room(dict: dict))
        }
        self.rooms = [Room]()
        self.rooms += data
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RoomTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RoomTableViewCell
        let room = rooms[indexPath.row]
        cell.nameLabel.text = room.name
        let currentPower = String(format: "%.0f", room.powerData.last!)
        cell.powerConsumptionLabel.text = "\(currentPower) W"
        let currentTemp = String(format: "%.0f", room.temperature.last!)
        cell.temperatureLabel.text = "\(currentTemp)\u{00B0} C"
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Pressed Room " + String(NSDate().timeIntervalSince1970));
        let tabController = segue.destinationViewController as! UITabBarController
        let deviceTableViewController = tabController.viewControllers![0] as! DeviceTableViewController
        if let selectedRoomCell = sender as? RoomTableViewCell {
            let indexPath = tableView.indexPathForCell(selectedRoomCell)!
            let selectedRoom = rooms[indexPath.row]
            deviceTableViewController.room = selectedRoom
            tabController.navigationItem.title = selectedRoom.name
            let roomStatsController = tabController.viewControllers![1] as! StatsTableViewController
            roomStatsController.id = selectedRoom._id
            roomStatsController.type = "rooms"
            
        }
       

    }
    

}
