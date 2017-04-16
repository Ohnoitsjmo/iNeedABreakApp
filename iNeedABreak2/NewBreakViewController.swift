//
//  NewBreakViewController.swift
//  iNeedABreak2
//
//  Created by Robert Hensley on 12/6/16.
//  Copyright © 2016 Robert Hensley. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewBreakViewController: UIViewController {
    
    @IBOutlet weak var SchoolNameTitle: UILabel!
    
    @IBOutlet weak var BreakName: UITextField!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBOutlet weak var BreakStored: UILabel!
    
    @IBOutlet weak var Date: UILabel!
    
    var schoolSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let x = UserDefaults.standard.object(forKey: "schoolSelected") {
            SchoolNameTitle!.text = x as? String
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateBreak(_ sender: Any) {
        if BreakName.text!.isEmpty {
            //creates an alert saying BreakName must be filled
            let alertController = UIAlertController(title: "Hey You!", message: "Put a name in for your break!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default,handler:nil))
            
            self.present(alertController, animated: true,  completion: nil)
        }
            
        else {
            let chosenDate = self.DatePicker.date
            print(chosenDate)
            //conversion of .date to string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: chosenDate as Date)
            print(dateString)
            
            BreakStored.text = "Break Stored: " + BreakName.text!
            Date.text = dateString
            
            //uploading the package to Firebase
            let ref = FIRDatabase.database().reference()
                let School = ref.child(SchoolNameTitle.text!)
                    let SchoolName = School.child("SchoolName")
                        SchoolName.setValue(SchoolNameTitle.text!)
                let Breaks = School.child("Breaks")
                    let Break = Breaks.child(dateString)
                        let FBBreakName = Break.child("BreakName")
                            FBBreakName.setValue(BreakName.text)
                        let FBBreakDate = Break.child("BreakDate" as String)
                            FBBreakDate.setValue(dateString)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
