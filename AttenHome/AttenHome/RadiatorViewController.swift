//
//  RadiatorViewController.swift
//  AttenHome
//
//  Created by Attentec-63 on 04/04/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import UIKit

class RadiatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var device: Radiator?
    
    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet weak var powerConsumptionLabel: UILabel!
    @IBOutlet weak var effectPicker: UIPickerView!
    
    @IBAction func switchClicked(sender: AnyObject) {
        if self.powerSwitch.on != true {
            self.powerConsumptionLabel.text = "0"
        }else{
            self.powerConsumptionLabel.text = String(Int(device!.powerConsumption)*(effectPicker.selectedRowInComponent(0)+1))
        }
        updatePowerSwitch()
    }
    
    var pickerData: [String] = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        self.effectPicker.delegate = self
        self.effectPicker.dataSource = self
        self.effectPicker.selectRow((self.device?.temp)!-1, inComponent: 0, animated: false)
        
        self.powerSwitch.on = (self.device?.powered)!
        if self.powerSwitch.on != false {
            self.powerConsumptionLabel.text = String(Int(self.device!.powerConsumption)*(self.device?.temp)!)
        }else{
            self.powerConsumptionLabel.text = "0"
        }
        let bi = UIBarButtonItem(image: UIImage(named: "Attentec.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        tabBarController?.navigationItem.rightBarButtonItem = bi
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text = pickerData[row]
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: "Lato", size: 15) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.device?.temp = row+1
        if self.powerSwitch.on != false {
            self.powerConsumptionLabel.text = String((row+1)*Int((self.device?.powerConsumption)!))
        }else{
            self.powerConsumptionLabel.text = "0"
        }

        
        APICalls.updateDevice(self.device!)
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
        self.device?.powered = self.powerSwitch.on
        APICalls.updateDevice(self.device!)
    }

}
