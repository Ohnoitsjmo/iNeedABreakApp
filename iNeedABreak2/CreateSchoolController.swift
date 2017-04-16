//
//  CreateSchoolController.swift
//  iNeedABreak2
//
//  Created by Robert Hensley on 11/12/16.
//  Copyright © 2016 Robert Hensley. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateSchoolController: UIViewController {

    // UITableViewDataSource, UITableViewDelegate
    
    @IBOutlet weak var SchoolNameTitle: UILabel!

    @IBOutlet weak var BreakName: UITextField!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBOutlet weak var DateLabelTest: UILabel!
    
    @IBOutlet weak var Date: UILabel!
    
    var passedData: String?
    
    //let now = Date()
    
    //Calendar Stuff
    let formatter = DateFormatter().date
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view

        SchoolNameTitle.text = passedData as String!
        
        //Keyboard stuff below
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateSchoolController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //consider making an if/else statement creating an alert when someone attempts to make a date before current date
    
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
            
    DateLabelTest.text = "Break Stored: " + BreakName.text!
    Date.text = dateString

    //uploading the date package to Firebase
        let ref = FIRDatabase.database().reference()
            let School = ref.child(SchoolNameTitle.text!)
                let SchoolName = School.child("SchoolName")
                    SchoolName.setValue(SchoolNameTitle.text!)
                let Breaks = School.child("Breaks")
                    let Break = Breaks.child(dateString)
                        Break.setValue(["BreakName":BreakName.text!,"BreakDate":dateString as String!])
            

        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
