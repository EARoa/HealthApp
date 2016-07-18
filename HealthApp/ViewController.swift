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
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dataButtonWasPressed(){
        
        let calendar = NSCalendar.currentCalendar()
        let startDate = calendar.dateByAddingUnit(.Day, value: -7, toDate: NSDate(), options: [])
        
        
        let day = calendar.dateByAddingUnit(.Day, value: 0, toDate: NSDate(), options:[])
        
        
        let graphs = [day, startDate]
        
        
        print(graphs)
        
        self.pedometer.queryPedometerDataFromDate(startDate!, toDate: NSDate()) { (data :CMPedometerData?, error :NSError?) in
            
            if let data = data {
                print(data.numberOfSteps)
                
                let stepCount = data.numberOfSteps
                
                let stepDouble = Double(stepCount)     // 2
                let negativeNumber = (stepDouble * -1) / 130
                
                dispatch_async(dispatch_get_main_queue(), {
                
                let coolView = UIView(frame: CGRectMake(10,450,390,250))
                coolView.backgroundColor = UIColor(red:0.00, green:0.62, blue:0.91, alpha:1.00)
                self.view.addSubview(coolView)
                    
                    let firstBar = UIView(frame: CGRectMake(10,250,50,CGFloat(negativeNumber)))
                    firstBar.backgroundColor = UIColor.greenColor()
                    coolView.addSubview(firstBar)
                    
                    let stepValueNumber = UILabel(frame: CGRectMake(10,190,100,100))
                    stepValueNumber.text = String(format:"%.0f",stepDouble)
                    coolView.addSubview(stepValueNumber)
                    
                })
            }
        }
    }
}

