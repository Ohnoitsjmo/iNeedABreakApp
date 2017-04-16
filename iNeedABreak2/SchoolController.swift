//
//  SchoolController.swift
//  iNeedABreak2
//
//  Created by Robert Hensley on 11/12/16.
//  Copyright © 2016 Robert Hensley. All rights reserved.
//

import UIKit
import FirebaseDatabase
// import FirebaseDatabaseUI

class SchoolController: UIViewController {

    @IBOutlet weak var SchoolName: UITextField!
    
    @IBOutlet weak var BreakTable: UITableView!
    
//    var fbDataSource: FUITableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
}
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }
    
    @IBAction func CreateBreakSeg(_ sender: Any) {
        if SchoolName.text!.isEmpty {
            let alertController = UIAlertController(title: "Hey You!", message: "Put a name in for your school!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default,handler:nil))
            
            self.present(alertController, animated: true,  completion: nil)
        }
        else {
            SchoolName.isUserInteractionEnabled = false
            let userInput = SchoolName.text
            performSegue(withIdentifier: "goToNewBreak", sender: userInput)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNewBreak" {
            if let destination = segue.destination as? CreateSchoolController {
                destination.passedData = sender as? String
                print("Sender Value: \(sender)")
            }
        }
    }
    
    @IBAction func Done(_ sender: Any) {

        if SchoolName.text!.isEmpty {
            let alertController = UIAlertController(title: "Hey You!", message: "Put a name in for your school!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default,handler:nil))
            
            self.present(alertController, animated: true,  completion: nil)
        }
            //create second if statement for no Breaks here
        else {
            //just do it!!!
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
