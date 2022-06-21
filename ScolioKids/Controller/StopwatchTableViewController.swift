//
//  StopwatchTableViewController.swift
//  ScolioKids
//
//  Created by Dessana Santos on 17/06/22.
//

import UIKit
import CoreData

class StopwatchTableViewController: UITableViewController {
    
    
    @IBOutlet var stopwatchUI: UITableView!
    
    //let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: , height: <#T##CGFloat#>))
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "coredata")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("erro de load \(error)")
            }
        }
        return container.viewContext
    }()

    var chronometer: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Chronometer")
        
        //3
        do {
        chronometer = try context.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        stopwatchUI.delegate = self
        stopwatchUI.dataSource = self
        stopwatchUI.reloadData()
  
    }

    // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {


        let deleteAction = UIContextualAction(style: .destructive, title:  "Delete", handler:{[self] (_, _, completionHandler) in
            // delete the item here

            context.delete(self.chronometer[indexPath.row])
            self.chronometer.remove(at: indexPath.row)
            // Save Changes
            appDelegate!.saveContext()
            // Remove row from TableView
            self.stopwatchUI.deleteRows(at: [indexPath], with: .left)

            completionHandler(true)

        })

        let action = UISwipeActionsConfiguration(actions: [deleteAction])

        return action


    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
        return chronometer.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let chronometerExercise = chronometer[indexPath.row]
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "reusebleChronometerCell", for: indexPath)
//        cell.textLabel?.text = "hello world"
            cell.textLabel?.text = chronometerExercise.value(forKeyPath: "chronometerName") as? String
    
        return cell
    }
    

}
