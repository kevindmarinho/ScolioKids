//
//  SecondViewController.swift
//  ScolioKids
//
//  Created by Anne Victoria Batista Auzier on 31/05/22.
//

import Foundation
import UIKit
import CoreData

class SecondViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var SelectionButton: UIBarButtonItem!
    @IBOutlet weak var ExercicioView: UITableView!
    
    var actionsModel = ActionsModel()
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "backgroundOficial")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    
    //COREDATA
    
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
    var chronometer: [NSManagedObject] = []
    
    //Search

    var searchExercicies = [String]()
    var searching = false
    
    // TableCell

    let exercises = [
        "Aviãozinho",
        "Prancha Lateral"
    ]
 
    var isCellSelected: Bool = false
    var SomeCellSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Exercício"
        
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        
        ExercicioView.delegate = self
        ExercicioView.dataSource = self
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        ExercicioView.delegate = self
        ExercicioView.dataSource = self
        ExercicioView.reloadData()
    }
    
    @IBAction func seleciona(_ sender: Any) {
        ExercicioView.allowsSelection = true
        ExercicioView.reloadData()
        
        if !isCellSelected {
           modifyBarButtonTitle()
        }
        
        else{
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
               
            let addToFavourites = UIAlertAction(title: "Add to favourites",style: .default,handler: { (action) ->Void in
            //Adicionar a transição de tela aqui
            let alert = UIAlertController(title: "Exercises favorited",
                                          message: "The selected exercises were favorited!",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            
            self.isCellSelected = false
            self.SelectionButton.title = "Selecionar"
            self.present(alert, animated: true)
    })
            if SomeCellSelected {
        let sendToStopwatch = UIAlertAction(title: "Send to Stopwatch", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
               
        actionSheet.addAction(addToFavourites)
        actionSheet.addAction(sendToStopwatch)
        actionSheet.addAction(cancelAction)
               
        self.present(actionSheet, animated: true, completion: nil)
            }
        }
    }
}

extension SecondViewController: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchExercicies = exercises.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        ExercicioView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        ExercicioView.reloadData()
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
//        ExercicioView.reloadData()
        
        
        
        
        //CRONOMETRO
        //FAVORITOS
        var chronometerActionTitle = "Chronos" // 7
        
        let chronometerRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chronometer")
              
              //3
        chronometerRequest.predicate = NSPredicate(format: "chronometerName = %@", "\(actionsModel.exercisesList[indexPath.row].exercise)")
//        request.predicate = NSPredicate(format: "isFavorited = %@", true)
              chronometerRequest.returnsObjectsAsFaults = false
              do {
                  let chronometer = try actionsModel.context.fetch(chronometerRequest)
                 
                  //5
                  for data in chronometer as! [NSManagedObject]
                  {
                      var boolean = data.value(forKey: "isFavorited") as! Bool
                      
                      if boolean == true {
                          // 7
                          chronometerActionTitle = "UnChronos"
//                          context.delete(data)
                      }
                      //
                      do {
                          try actionsModel.context.save()
                      }
                      catch {
                          // Handle Error
                      }
                  }
                  
              } catch {
                  print("Failed")
              }
        
        let chronometerAction = UIContextualAction(style: .normal, title: chronometerActionTitle, handler:{[self] (_, _, completionHandler) in
            // delete the item here
            
          
            if chronometerActionTitle == "Favorite" {
            
                actionsModel.savingToChronometer(index: indexPath.row)

            }
            
            if chronometerActionTitle == "Unfavorite" {
     
                actionsModel.deleteFromChronometer(index: indexPath.row)
         
            }
            
            self.actionsModel.exercisesList[indexPath.row].isChronometer.toggle()
                
            completionHandler(true)
  
        })
       
  
        
        
        //FAVORITOS
        var favoriteActionTitle = "Favorite" // 7
        
        let favoritesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
              
              //3
        favoritesRequest.predicate = NSPredicate(format: "favoritesName = %@", "\(actionsModel.exercisesList[indexPath.row].exercise)")
//        request.predicate = NSPredicate(format: "isFavorited = %@", true)
              favoritesRequest.returnsObjectsAsFaults = false
              do {
                  let favorites = try actionsModel.context.fetch(favoritesRequest)
                 
                  //5
                  for data in favorites as! [NSManagedObject]
                  {
                      var boolean = data.value(forKey: "isFavorited") as! Bool
                      
                      if boolean == true {
                          // 7
                          favoriteActionTitle = "Unfavorite"
//                          context.delete(data)
                      }
                      //
                      do {
                          try actionsModel.context.save()
                      }
                      catch {
                          // Handle Error
                      }
                  }
                  
              } catch {
                  print("Failed")
              }
        
        

       
        let favoriteAction = UIContextualAction(style: .normal, title:  favoriteActionTitle, handler:{ [self] (_, _, completionHandler) in
            // delete the item here

            let userExercises = actionsModel.exercisesList[indexPath.row].exercise
            if favoriteActionTitle == "Favorite" {
            
                actionsModel.savingToFavorites(index: indexPath.row)

            }
            
            if favoriteActionTitle == "Unfavorite" {
     
                actionsModel.deleteFromFavorites(index: indexPath.row)
         
            }
                

              
            
            self.actionsModel.exercisesList[indexPath.row].isFavorited.toggle()
                
            completionHandler(true)
            
        })
        
  
        if favoriteActionTitle == "Favorite" {
            favoriteAction.image = UIImage(systemName: "heart")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal) }
        
        if favoriteActionTitle == "Unfavorite" {
            
            favoriteAction.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            
        }

        
        
        favoriteAction.image?.withTintColor(UIColor.systemRed)
//        favoriteAction.backgroundColor = UIColor.systemBlue
//        chronometerAction.backgroundColor = UIColor.systemMint
        
        
//        return [chronometerAction, favoriteAction]
        let action = UISwipeActionsConfiguration(actions: [chronometerAction, favoriteAction])
        
        return action
      
//        ExercicioView.reloadData()
   


    }

    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchExercicies.count
        } else {
            return actionsModel.exercisesList.count
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = ExercicioView.dequeueReusableCell(withIdentifier: "customcell") as! CustomCell
        
//        let lista = exercises[indexPath.row]
        let lista = actionsModel.exercisesList[indexPath.row].exercise
        
        cells.nameLabel?.text = lista
//        cells.assetsImg.image = UIImage(named: lista)
        
        if searching {
            cells.nameLabel.text = searchExercicies[indexPath.row]
//          cells.assetsImg.image = UIImage(named: searchExercicies[indexPath.row])!
        } else {
//            cells.nameLabel.text = exercises[indexPath.row]
            cells.nameLabel.text = lista
        }
        if cells.isSelected {
            SomeCellSelected = true
        } else {
            SomeCellSelected = false
        }
        
        return cells
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SomeCellSelected = true
        let passa = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        if searching{
            passa?.title = searchExercicies[indexPath.row]
        }
        else{
            passa?.title = exercises[indexPath.row]
        }
        if !isCellSelected {
            
            isCellSelected = false
            
            if let customCell = tableView.cellForRow(at: indexPath) as? CustomCell,
               let trainningName = customCell.nameLabel.text{
                passa?.nameTrainning = "\(trainningName)"
            }
            self.navigationController?.pushViewController(passa!, animated: true)
            ExercicioView.reloadData()
        }
    }
    func modifyBarButtonTitle() {
            isCellSelected = true
            SelectionButton.title = "OK"
        }
}


    



