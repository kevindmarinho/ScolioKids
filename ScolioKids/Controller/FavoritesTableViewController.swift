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
    
    var filterFav: [Favorites] = []
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
        
        searchFav.placeholder = "Buscar Exercício"
        searchFav.delegate = self
        
       // self.filterFav = favorites
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")

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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 70
      }
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
        
        if searching2 {
            
            return filterFav.count
        }
        else {
            return favorites.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        let favoritesExercise = favorites[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusebleFavoritesCell", for: indexPath)
        
        if searching2 {
            cell.textLabel?.text = filterFav[indexPath.row].favoritesName

        } else {
            cell.textLabel?.text = favoritesExercise.value(forKeyPath: "favoritesName") as? String
        }
                   
//        cell.textLabel?.text = favoritesExercise.value(forKeyPath: "favoritesName") as? String
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let passa2 = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        if searching2 {
            passa2?.title = filterFav[indexPath.row].favoritesName
        }
        else{
        // passa2?.title = actionsModel.exercisesList[indexPath.row].exercise
            passa2?.title = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? ""
        }
        
        passa2?.nameTrainning = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? ""
        
      //  passa2?.title = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? ""
        
//        passa2?.title = actionsModel.exercisesList[indexPath.row].exercise
        
        navigationController?.pushViewController(passa2!, animated: true)

        favoritesUI.reloadData()
    }
    
    // Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let favoritos = favorites as! [Favorites]

        if searchText.isEmpty{
            self.filterFav = favoritos
        }
        else{
            
            filterFav = favoritos.filter(){ favorito in
                return favorito.favoritesName?.contains(searchText) ?? false
                
        }
        
            for favorito in filterFav{
                print(favorito.favoritesName ?? "nao tem")
            }
        }
        
//            else{
//            for value in actionsModel.exercisesList{
//                if value.exercise.uppercased().contains(searchText.uppercased()){
//                    self.filterFav.append(value)
//                }
//            }
//        }

        searching2 = true
        favoritesUI.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchFav.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching2 = false
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

