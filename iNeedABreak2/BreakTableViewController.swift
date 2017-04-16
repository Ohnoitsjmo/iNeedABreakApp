//
//  BreakTableViewController.swift
//  iNeedABreak2
//
//  Created by Robert Hensley on 11/22/16.
//  Copyright © 2016 Robert Hensley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class BreakTableViewController: UITableViewController {
    
    var fbDataSource: FUITableViewDataSource?
    
    var schoolSelected: String?
    
    var x: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //tableView.allowsMultipleSelectionDuringEditing = true
        
         if let x = UserDefaults.standard.object(forKey: "schoolSelected") {
                        schoolSelected = x as? String
                    }
            
                    print(schoolSelected!)
        
            let ref = FIRDatabase.database().reference().child(schoolSelected!).child("Breaks")
            
            let q = ref.queryOrdered(byChild: "Break")
            
            print (q)
            
            fbDataSource = FUITableViewDataSource(query: q, view: tableView){
                (tableView: UITableView, indexPath: IndexPath, data: FIRDataSnapshot) -> UITableViewCell in
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "BreakCell", for: indexPath) as! BreakTableViewCell
                
                cell.data = data
                
                cell.breakName!.text = data.childSnapshot(forPath: "BreakName").value as? String
                cell.breakDate!.text = data.childSnapshot(forPath: "BreakDate").value as? String
                
                return cell
                
            }
            
            tableView.dataSource = fbDataSource
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreakCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    
*/
 

    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }


     //Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        self.tableView.deleteRows(at: [IndexPath(row: index, section: self.kSectionComments)], with: UITableViewRowAnimation.automatic)
//               // if editingStyle == .delete {
////                    let row = self.fbDataSource[indexPath.row]
////                    //row.ref.removeValue()
////                    self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .Automatic)
//           //fbDataSource.deleteRows(at: [indexPath], with: .fade)
//       // }
//          //      else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       // }
//    }


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

    @IBAction func newBreak(_ sender: Any) {
        if let x = UserDefaults.standard.object(forKey: "schoolSelected") {
            schoolSelected = x as? String
            print(schoolSelected!)
        }
        performSegue(withIdentifier: "goToNewBreak2", sender: schoolSelected)
        
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "goToNewBreak2" {
            let destination = segue.destination as? CreateSchoolController
            destination!.passedData = schoolSelected
        }
        
    }


}
