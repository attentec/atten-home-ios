//
//  StatsTableViewController.swift
//  AttenHome
//
//  Created by Attentec-62 on 01/04/16.
//  Copyright © 2016 Attentec. All rights reserved.
//

import UIKit
import Charts

class StatsTableViewController: UITableViewController {
    
    var data = [[Double]]()
    var id : String?
    var type: String?
    var selectedRows = [false,false]
    
    let expandedImage = UIImage(named: "Up@3x.png")
    let collapsedImage = UIImage(named: "Down@3x.png")
    var origHeight: CGFloat?
    
    let metaData = [("Power Consumption","W"), ("Temperature","\u{00B0} C")]
    
    override func viewDidLoad() {
        print("Stats view loaded " + String(NSDate().timeIntervalSince1970));
        super.viewDidLoad()
        if id == nil || type == nil{
            id = "56e7e5e8c798cfaf310641b7"
            type = "houses"
        }
        self.loadData()
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "loadData", userInfo: nil, repeats: true)
        origHeight = tableView.rowHeight
    }
    
    func loadData(){
        APICalls.getObject(type!, id: id!, callback: self.refreshTable)
    }
    
    func refreshTable(result : NSDictionary){
        data = []
        data.append((result.valueForKey("powerData") as? [Double])!)
        if let p = result.valueForKey("temperature") as? [Double]{
         data.append(p)
        }
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
        return data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "StatsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StatsTableViewCell
        let stats = data[indexPath.row]
        let current = String(format: "%.1f", stats[stats.count-1])
        let (title, unit) = metaData[indexPath.row]
        cell.titleLabel.text = "\(title): \(current) \(unit)"
        setupChart(cell.lineChart, data: stats)
        
        if(selectedRows[indexPath.row]){
            cell.expandImage.image = expandedImage
            cell.lineChart.hidden = false
        }
        else{
            cell.expandImage.image = collapsedImage
            cell.lineChart.hidden = true

        }
        return cell
    }
    
    func setupChart(lineChart: LineChartView, data: [Double]){
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = 2
        lineChart.leftAxis.valueFormatter = formatter
        lineChart.leftAxis.axisMinValue = 0
        lineChart.data = getChartData(data)
        lineChart.descriptionText = ""
        lineChart.legend.enabled = false
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.setLabelsToSkip(1)
        lineChart.xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom

    }
    
    func getChartData(data: [Double]) -> LineChartData{
        var dataEntries: [ChartDataEntry] = []
        var xVals: [String] = []
        for i in 0..<21 {
            let entry = ChartDataEntry(value: data[data.count-1-i], xIndex: 20-i)
            dataEntries.append(entry)
            xVals.append("\(i)")
        }
        
        let dataSet = LineChartDataSet(yVals: dataEntries, label: "")
        dataSet.drawValuesEnabled = false
        dataSet.circleRadius = 3
        let aRed = NSUIColor.init(netHex: 0x910B26)
        dataSet.setCircleColor(aRed)
        dataSet.setColor(aRed)
        let chartData = LineChartData(xVals: xVals, dataSet: dataSet)
        return chartData
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRows[indexPath.row] = !selectedRows[indexPath.row]
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedRows[indexPath.row] {
            return origHeight!+300
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
