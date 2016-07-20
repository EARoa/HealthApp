//
//  ViewController.swift
//  HealthApp
//
//  Created by Efrain Ayllon on 7/16/16.
//  Copyright © 2016 Efrain Ayllon. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var pedometer = CMPedometer()
    @IBOutlet weak var labelForSteps :UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pedometer = CMPedometer()
        self.pedometer.startPedometerUpdatesFromDate(NSDate()) { (data :CMPedometerData?, error :NSError?) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dataButtonWasPressed(){
        let coolView = UIView(frame: CGRectMake(0,450,450,250))
        coolView.backgroundColor = UIColor(red:0.00, green:0.62, blue:0.91, alpha:1.00)
        self.view.addSubview(coolView)
            for day in 1...7 {
            let calendar = NSCalendar.currentCalendar()
            guard let startDate = calendar.dateByAddingUnit(.Day, value: -1 * day, toDate: NSDate(), options: []) else {
                fatalError("Unable to get date")
            }
        
        // Not sure why I did this but it works!
        let initialX = 60
        let xValueForBar = (initialX * day) - 55
        print(xValueForBar)

        self.pedometer.queryPedometerDataFromDate(startDate, toDate: NSDate()) { (data :CMPedometerData?, error :NSError?) in
            
            if let data = data {
                let stepCount = data.numberOfSteps
                let stepDouble = Double(stepCount)     // 2
                let negativeNumber = (stepDouble * -1) / 130
                
                dispatch_async(dispatch_get_main_queue(), {
                    let bar = UIView(frame: CGRectMake(CGFloat(xValueForBar),250,45,CGFloat(negativeNumber)))
                    bar.backgroundColor = UIColor.greenColor()
                    coolView.addSubview(bar)
                    
                    let stepValueNumber = UILabel(frame: CGRectMake(CGFloat(xValueForBar),0,100,100))
                    stepValueNumber.text = String(format:"%.0f",stepDouble)
                    coolView.addSubview(stepValueNumber)
                    
                })
            }
        }
    }
}
}