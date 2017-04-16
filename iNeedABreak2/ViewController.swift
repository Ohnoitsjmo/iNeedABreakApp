//
//  ViewController.swift
//  iNeedABreak2
//
//  Created by Robert Hensley on 11/12/16.
//  Copyright © 2016 Robert Hensley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class ViewController: UIViewController {

    @IBOutlet weak var breakName: UILabel!
    
    //Time Variables
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var minuteLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var schoolSelected: UILabel!
    
    var fbDataSource: FUITableViewDataSource?
    
    var data: FIRDataSnapshot?
    
    var TLC: String?
    
    var FBdate: String?
    
    var FBname: String?
    
    //Countdown Stuff
    
    let formatter = DateFormatter()
    
    var dateString: Date? = Date()
    
    var end: String?
    
    let userCalendar = Calendar.current;
    
    let requestedComponent: Set<Calendar.Component> = [
    Calendar.Component.month,
    Calendar.Component.day,
    Calendar.Component.hour,
    Calendar.Component.minute,
    Calendar.Component.second
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
            
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        
            timer.fire()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "schoolSelected") {
            schoolSelected.text = x as? String
        }
        else {
            performSegue(withIdentifier: "goToSchList", sender: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    func timeCalculator(dateFormat: String, endTime: String, startTime: Date = Date()) -> DateComponents {
        
        formatter.dateFormat = "yy/MM/dd hh:mm:ss +0000"
        let _startTime = startTime
        let _endTime = formatter.date(from: endTime)
        
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: _startTime, to: _endTime!)
        return timeDifference
        
    }
    
    func printTime() -> Void {
        
        let ref = FIRDatabase.database().reference().child(schoolSelected.text!).child("Breaks")
        
        let q = ref.queryOrdered(byChild: "Break").queryLimited(toFirst: 1)
        
        print (q)
        
        q.observe(.childAdded) {
            (data:FIRDataSnapshot) in
            print(data)
            
            self.FBdate = data.childSnapshot(forPath: "BreakDate").value as? String
            self.FBname = data.childSnapshot(forPath: "BreakName").value as? String
            
            print(self.FBname!)
            
              //conversion back to NSDateFormat
        
            self.formatter.dateFormat = "yyyy-MM-dd"
            self.dateString = self.formatter.date(from: self.FBdate!)
            self.formatter.dateFormat = "yyyy/MM/dd hh:mm:ss +0000"
            self.end = self.formatter.string(from: self.dateString!)
            print(self.dateString!)
            print(self.end!)
                    
                    let timeDifference = self.timeCalculator(dateFormat: "yyyy/MM/dd hh:mm:ss +0000", endTime: self.end!)
                    
                    if timeDifference.second! < 0 {
                        FIRDatabase.database().reference().child(self.schoolSelected.text!).child("Breaks").child(self.FBdate!).removeValue()
                    
                    }
            
                    if timeDifference.second! >= 0 {
                    self.breakName.text! = self.FBname!
                    self.breakName.textColor = UIColor.black
                
                    self.monthLabel.text = "\(timeDifference.month!) Months"
                    self.monthLabel.textColor = UIColor.black
                    
                    self.dayLabel.text = "\(timeDifference.day!) Days"
                    self.dayLabel.textColor = UIColor.black
                    
                    self.hourLabel.text = "\(timeDifference.hour!) Hours"
                    self.hourLabel.textColor = UIColor.black
                    
                    self.minuteLabel.text = "\(timeDifference.minute!) Minutes"
                    self.minuteLabel.textColor = UIColor.black
                    
                    self.secondLabel.text = "\(timeDifference.second!) Seconds"
                    self.secondLabel.textColor = self.randomColor()
            }
            
        
        }
        
        /*
         
         // Used if no breaks are in a school. Problem is that this causes flickering each time q is observed
         self.breakName.textColor = UIColor.red
         self.breakName.text  = "No Upcoming Breaks"
         
         self.monthLabel.text = "0 Months"
         self.monthLabel.textColor = UIColor.red
         
         self.dayLabel.text = "0 Days"
         self.dayLabel.textColor = UIColor.red
         
         self.hourLabel.text = "0 Hours"
         self.hourLabel.textColor = UIColor.red
         
         self.minuteLabel.text = "0 Minutes"
         self.minuteLabel.textColor = UIColor.red
         
         self.secondLabel.text = "0 Seconds"
         self.secondLabel.textColor = UIColor.red
         */
        
        
        if end == nil {
            print("Houston we have una problema!")
            }
        
    }

        //"2016/05/08 12:00:00 +0000" is christmas :)
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        if segue.identifier == "SchoolSelected" {
            let schoolStored = data?.childSnapshot(forPath: "SchoolName").value as? String
            UserDefaults.standard.set(schoolStored, forKey: "schoolSelected")
        }
        if segue.identifier == "Done" {
            UserDefaults.standard.set(TLC, forKey: "schoolSelected")
        }
    }

    
    private func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(150)) / 150.0
        let green = CGFloat(arc4random_uniform(150)) / 150.0
        let blue = CGFloat(arc4random_uniform(150)) / 150.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
    }
}
