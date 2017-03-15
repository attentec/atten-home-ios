//
//  RoomTableViewController.swift
//  AttenHome
//
//  Created by Attentec-62 on 23/03/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import UIKit

class DeviceTableViewController: UITableViewController {
    
    // MARK: Properties
    var devices = [Device]()
    var room: Room?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bi = UIBarButtonItem(image: UIImage(named: "Attentec.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        tabBarController?.navigationItem.rightBarButtonItem = bi
        tabBarController?.navigationItem.backBarButtonItem
    }
    
    override func viewWillAppear(true:Bool) {
        print("DeviceList loaded " + String(NSDate().timeIntervalSince1970));
        super.viewWillAppear(true)
        loadData()
    }
    
    func loadData(){
        let params = ["roomId":room!._id]
        APICalls.getArray("devices", params: params, callback: self.tableRefresh)
    }
    
    func tableRefresh(result: [NSDictionary]) {
        var data = [Device]()
        for dict in result {
            if dict["__t"]!.isEqualToString("Lamp"){
                data.append(Lamp(dict: dict))
            }else if dict["__t"]!.isEqualToString("Radiator"){
                data.append(Radiator(dict: dict))
            }
        }
        self.devices = [Device]()
        self.devices += data
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
        return devices.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DeviceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DeviceTableViewCell
        let device = devices[indexPath.row]
        cell.nameLabel.text = device.name
        cell.powerSwitch.on = device.powered
        cell.powerSwitch.tag = indexPath.row
        cell.powerSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        if let rad = device as? Radiator {
            let currentTemp = String(format: "%.0f", rad.temperature.last!)
            cell.tempLabel.text = "\(currentTemp)\u{00B0} C"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if devices[indexPath.row].__t == "Lamp" {
            performSegueWithIdentifier("LampSegue", sender: devices[indexPath.row])
        }else {
            performSegueWithIdentifier("RadiatorSegue", sender: devices[indexPath.row])
        }
    }

    func stateChanged(powerSwitch: UISwitch){
        let device = devices[powerSwitch.tag]
        device.powered = powerSwitch.on
        APICalls.updateDevice(device)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Pressed device " + String(NSDate().timeIntervalSince1970));
        let tabController = segue.destinationViewController as! UITabBarController
        if let settingsViewController = tabController.viewControllers![0] as? LampViewController {
            let lampDevice = sender as! Lamp
            settingsViewController.device = lampDevice
            tabController.navigationItem.title = lampDevice.name
            let deviceStatsController = tabController.viewControllers![1] as! StatsTableViewController
            deviceStatsController.id = lampDevice._id
            deviceStatsController.type = "devices"
        }else if let settingsViewController = tabController.viewControllers![0] as? RadiatorViewController{
            let radiatorDevice = sender as! Radiator
            settingsViewController.device = radiatorDevice
            tabController.navigationItem.title = radiatorDevice.name
            let deviceStatsController = tabController.viewControllers![1] as! StatsTableViewController
            deviceStatsController.id = radiatorDevice._id
            deviceStatsController.type = "devices"
        }
        
    }
    
}
