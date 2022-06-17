//
//  FavoritesTableViewController.swift
//  ScolioKids
//
//  Created by Dessana Santos on 17/06/22.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {

    
    
    @IBOutlet var favoritesUI: UITableView!
    
    
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
    
    
    var favorites: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
  
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        
        //3
        do {
          favorites = try context.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        favoritesUI.delegate = self
        favoritesUI.dataSource = self
        favoritesUI.reloadData()
    }

    // MARK: - Table view data source

  
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
//        ExercicioView.reloadData()
        
        let deleteAction = UIContextualAction(style: .destructive, title:  "Delete", handler:{[self] (_, _, completionHandler) in
            // delete the item here
            
            context.delete(self.favorites[indexPath.row])
            self.favorites.remove(at: indexPath.row)
            // Save Changes
            appDelegate!.saveContext()
            // Remove row from TableView
         self.favoritesUI.deleteRows(at: [indexPath], with: .left)
            
            completionHandler(true)
            
//            self.modelBrain.nomeExercicios.remove(at: indexPath.row)
//            self.ExercicioView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        let action = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return action
      
//        ExercicioView.reloadData()
   


    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return favorites.count
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let favoritesExercise = favorites[indexPath.row]
            let cell =
              tableView.dequeueReusableCell(withIdentifier: "reusebleFavoritesCell",
                                            for: indexPath)
            cell.textLabel?.text = favoritesExercise.value(forKeyPath: "favoritesName") as? String
//        cell.textLabel?.text = "hello world"
        return cell
    }
    

}
