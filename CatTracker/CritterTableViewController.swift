//
//  CritterTableViewController.swift
//  CatTracker
//
//  Created by LING Leong on 23/3/2017.
//  Copyright © 2017 LING Leong. All rights reserved.
//

import UIKit
import os.log

class CritterTableViewController: UITableViewController {
    //MARK: Properties
    var critters = [Critter]()
    

    
    private func loadSampleCats(){
        let photo1 = UIImage(named: "SampleCat1")
        let photo2 = UIImage(named: "SampleCat2")
        let photo3 = UIImage(named: "SampleCat3")
        
   
        
        guard let cat1 = Critter(name: "ChungChi Cat", photo: photo1!, details: "in ChungChi restaurant") else {
            fatalError("Unable to instantiate cat1")
        }
        guard let cat2 = Critter(name: "SHB Cat", photo: photo2!, details: "in car park outside ERB") else {
            fatalError("Unable to instantiate cat2")
        }
        guard let cat3 = Critter(name: "NA Cat", photo: photo3!, details: "near NA water tower") else {
            fatalError("Unable to instantiate cat3")
        }
        
        
        let url = URL(string: "http://www.cse.cuhk.edu.hk/~shor/baby.jpg")
        let data = try? Data(contentsOf: url!)
        let photo4 = UIImage(data: data!)
        guard let cat4 = Critter(name: "network bird 1", photo: photo4!, details: "on Internet") else {
            fatalError("Unable to instantiate cat4")
        }
        
        critters += [cat1, cat2, cat3, cat4]
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        if let savedCritters = loadCritters() {
            critters += savedCritters
//            loadSampleCats()
        } else {
            loadSampleCats()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func unwindToCatList( sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? CritterViewController, let critter = sourceViewController.critter {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                critters[selectedIndexPath.row] = critter
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: critters.count, section: 0)
                critters.append(critter)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveCritters()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return critters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier  = "CritterTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CritterTableViewCell else {
            fatalError("The dequeued cell is not an instance of CritterTableViewCell")
        }
        let critter = critters[indexPath.row]
        cell.nameLabel.text = critter.name
        cell.photoImageView.image = critter.photo
        cell.details.text = critter.details

        // Configure the cell...

        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            critters.remove(at: indexPath.row)
            saveCritters()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new critter.", log: OSLog.default, type:.debug)
        case "ShowDetail":
            guard let critterDetailViewController = segue.destination as? CritterViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedCritterCell = sender as? CritterTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedCritterCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedCritter = critters[indexPath.row]
            critterDetailViewController.critter = selectedCritter
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Private Methods
    private func saveCritters() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject( critters, toFile: Critter.ArchiveURL!.path)
        if isSuccessfulSave {
            os_log("Critters successfully saved", log: OSLog.default,
                                                      type: .debug)
        } else {
            os_log("Failed to save", log: OSLog.default, type: .debug)
        }
    }
    
    private func loadCritters() -> [Critter]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile:
            (Critter.ArchiveURL?.path)!) as? [Critter]
    }
 

}
