//
//  StopwatchTableViewController.swift
//  ScolioKids
//
//  Created by Dessana Santos on 17/06/22.
//

import UIKit

class StopwatchTableViewController: UITableViewController {
    
    
    @IBOutlet var stopwatchUI: UITableView!
    var actionsModel = ActionsModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
  
        actionsModel.chronometerFetchRequest()
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

            actionsModel.context.delete(actionsModel.chronometer[indexPath.row])
            actionsModel.chronometer.remove(at: indexPath.row)
            // Save Changes
            do {
                try actionsModel.context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
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
        return actionsModel.chronometer.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let chronometerExercise = actionsModel.chronometer[indexPath.row]
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "reusebleChronometerCell", for: indexPath)
//        cell.textLabel?.text = "hello world"
            cell.textLabel?.text = chronometerExercise.value(forKeyPath: "chronometerName") as? String
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .boldSystemFont(ofSize: 18)
            
    
        return cell
    }
    

}
