//
//  CreateSchoolTableViewController.swift
//  iNeedABreak2
//
//  Created by Robert Hensley on 12/3/16.
//  Copyright © 2016 Robert Hensley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class CreateSchoolTableViewController: UITableViewController {
    
    var fbDataSource: FUITableViewDataSource?
    
    var data: FIRDataSnapshot?
    
    var FBDate: String?
    
    @IBOutlet weak var Textfield: UITextField!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       //  self.navigationItem.rightBarButtonItem = self.editButtonItem
        
            }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

/*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
*/

/*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print ("hey what up")
        
        if (self.tableView.isEditing) {
            print("hey there")
        }
        
        //return UITableViewCellEditingStyle.None;

        
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            print("delete")
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        
//            let schoolNew = Textfield.text!
//            
//            print(schoolNew)
//            
//            var FBDate = data?.childSnapshot(forPath: "BreakDate").value as? String
//            
//            //let ref = FIRDatabase.database().reference().child(schoolNew)
//            
//        FIRDatabase.database().reference().child(schoolNew).child("Breaks").child(self.FBDate!).removeValue()
        
        }
//        else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
    }
*/

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func CreateBreakSeg(_ sender: Any) {
        if Textfield.text!.isEmpty {
            let alertController = UIAlertController(title: "Hey You!", message: "Put a name in for your school!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default,handler:nil))
            
            self.present(alertController, animated: true,  completion: nil)
        }
            
        else {
            // disables text field
            Textfield.isUserInteractionEnabled = false
            let userInput = Textfield.text as String!
            performSegue(withIdentifier: "goToNewBreak", sender: userInput)
            print(userInput!)
            
            //Firebase Table Stuff
            let schoolNew = Textfield.text!
            
            let ref = FIRDatabase.database().reference().child(schoolNew).child("Breaks")
            
            let q = ref.queryOrdered(byChild: "Break")
            
            print (q)
            
            fbDataSource = FUITableViewDataSource(query: q, view: tableView){
                (tableView: UITableView, indexPath: IndexPath, data: FIRDataSnapshot) -> UITableViewCell in
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CreateCell", for: indexPath) as! CreateSchoolTableViewCell
                
                cell.data = data
                
                cell.dateName!.text = data.childSnapshot(forPath: "BreakName").value as? String
                cell.date!.text = data.childSnapshot(forPath: "BreakDate").value as? String
                
                return cell
            }
            
            tableView.dataSource = fbDataSource
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNewBreak" {
            let destination = segue.destination as? CreateSchoolController
            destination!.passedData = Textfield.text as String!
        }
        if segue.identifier == "Done" {
            let destination = segue.destination as? ViewController
            destination!.TLC = Textfield.text as String!
        }
        
        
    }
    
    @IBAction func done(_ sender: Any) {
        
        if Textfield.text!.isEmpty {
            let alertController = UIAlertController(title: "Hey You!", message: "Put a name in for your school!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default,handler:nil))
            self.present(alertController, animated: true,  completion: nil)
        }
    
        else {
            
            //Create Default School
            let TLC = Textfield.text! as String?
            
            performSegue(withIdentifier: "Done", sender: TLC)
        }

    
    }
    
    
}
