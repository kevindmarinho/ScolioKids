//
//  FavoritesTableViewController.swift
//  ScolioKids
//
//  Created by Dessana Santos on 17/06/22.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchFav: UISearchBar!
    @IBOutlet var favoritesUI: UITableView!
    
    var actionsModel = ActionsModel()
    
    var filterFav: [NSManagedObject] = []
    var searching2 = false
    
    var favorites: [NSManagedObject] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchFav.placeholder = "Buscar"
        searchFav.delegate = self
        self.filterFav = favorites
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        
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
        
        return favorites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let favoritesExercise = favorites[indexPath.row]
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "reusebleFavoritesCell", for: indexPath)
            cell.textLabel?.text = favoritesExercise.value(forKeyPath: "favoritesName") as? String
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicou")
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        self.present(homeViewController, animated: true)
        let passa2 = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController

        passa2?.title = actionsModel.exercisesList[indexPath.row].exercise
        navigationController?.pushViewController(passa2!, animated: true)

        favoritesUI.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterFav = []
        if searchText.isEmpty{
            self.filterFav = favorites
            
        }else{
            for value in favorites{
               // if value.uppercased().contains(searchText.uppercased()){
                    self.filterFav.append(value)
                //}
            }
                searching2 = true
                favoritesUI.reloadData()
        }
        favoritesUI.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchFav.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchFav.text = ""
        searchFav.resignFirstResponder()
        searchFav.setShowsCancelButton(false, animated: true)
        favoritesUI.reloadData()
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchFav.setValue("Cancelar", forKey: "cancelButtonText")
        searchFav.setShowsCancelButton(true, animated: true)
        return true
    }
}

