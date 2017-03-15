//
//  LampViewController.swift
//  AttenHome
//
//  Created by Attentec-63 on 04/04/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import UIKit

class LampViewController: UIViewController {
    
    var device: Lamp?
    
    @IBOutlet weak var powerConsumption: UILabel!
    
    @IBOutlet weak var dimmer: UISlider!
    
    @IBOutlet weak var `switch`: UISwitch!
    
    
    @IBAction func powerSwitch(sender: AnyObject) {
        if self.`switch`.on != true {
            self.powerConsumption.text = "0"
        }else{
            self.powerConsumption.text = String(Int(device!.powerConsumption*Double(self.dimmer.value)))
        }
        updatePowerSwitch()
    }
    @IBOutlet weak var dimmerLabel: UILabel!
    
    @IBAction func updateDimmerLabel(sender: AnyObject) {
        self.dimmerLabel.text = String(Int(self.dimmer.value*100)) + " %"
        if self.`switch`.on != false {
            self.powerConsumption.text = String(Int(device!.powerConsumption*Double(self.dimmer.value)))
        }
    }
    
    @IBAction func updateDimmerValueIn(sender: AnyObject) {
        updateDimmer()
    }
    
    @IBAction func updateDimmerValueOut(sender: AnyObject) {
        updateDimmer()
    }
    
    override func viewDidLoad() {
        print("Device loaded " + String(NSDate().timeIntervalSince1970))
        super.viewDidLoad()
        print(self.device?.dimmer)
        self.dimmer.value = Float((self.device?.dimmer)!)/100
        self.dimmerLabel.text = String(Int(self.dimmer.value*100)) + " %"
        self.`switch`.on = (self.device?.powered)!
        if self.`switch`.on != false {
            self.powerConsumption.text = String(Int(Float(self.device!.powerConsumption)*(self.dimmer.value)))
        }else{
            self.powerConsumption.text = "0"
        }
        let bi = UIBarButtonItem(image: UIImage(named: "Attentec.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        tabBarController?.navigationItem.rightBarButtonItem = bi
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.navigationController?.topViewController != self {
            print("Pressed back from device " + String(NSDate().timeIntervalSince1970))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func updatePowerSwitch(){
        self.device?.powered = self.`switch`.on
        APICalls.updateDevice(self.device!)
    }
    
    func updateDimmer(){
        self.device?.dimmer = Int(self.dimmer.value*100)
        APICalls.updateDevice(self.device!)
    }

}
