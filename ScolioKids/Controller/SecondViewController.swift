//
//  SecondViewController.swift
//  ScolioKids
//
//  Created by Anne Victoria Batista Auzier on 31/05/22.
//

import Foundation
import UIKit
//import CoreData

class SecondViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var ExercicioView: UITableView!

    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "backgroundOficial")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    //COREDATA - SINGLETON
    var actionsModel = ActionsModel()

    //Search
   // var searchExercicies = [String]()
    var filterUser: [Exercises] = []
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        title = "Exercícios"
        
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        
        ExercicioView.delegate = self
        ExercicioView.dataSource = self
        ExercicioView.reloadData()
        
        
        self.filterUser = actionsModel.exercisesList
        searchBar.placeholder = "Buscar"
        searchBar.delegate = self
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

// SEARCH
extension SecondViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // searchExercicies = exercises.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.filterUser = []
        if searchText.isEmpty {
            self.filterUser = actionsModel.exercisesList
        }else{
            for value in actionsModel.exercisesList{
                if value.exercise.uppercased().contains(searchText.uppercased()){
                    self.filterUser.append(value)
                }
            }
        }
        searching = true
        ExercicioView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        ExercicioView.reloadData()
    }
}

// Table View -> Exercícios
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //CRONOMETRO
        let chronometerActionTitle = actionsModel.changeChronometerTitleName(index: indexPath.row)

        
        let chronometerAction = UIContextualAction(style: .normal, title: chronometerActionTitle, handler:{[self] (_, _, completionHandler) in
            // delete the item here
            if chronometerActionTitle == "Chronos" {
                actionsModel.savingToChronometer(index: indexPath.row)
            }
            
            if chronometerActionTitle == "UnChronos" {
                
                actionsModel.deleteFromChronometer(index: indexPath.row)
            }
            self.actionsModel.exercisesList[indexPath.row].isChronometer.toggle()
            
            completionHandler(true)
            
        })
        
        //FAVORITOS
        
        let favoriteActionTitle = actionsModel.changeFavoritesTitleName(index: indexPath.row)
    
        
        let favoriteAction = UIContextualAction(style: .normal, title:  favoriteActionTitle, handler:{ [self] (_, _, completionHandler) in
            // delete the item here

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

            favoriteAction.image = UIImage(named: "Group-140")}
        
        if favoriteActionTitle == "Unfavorite" {
            
            favoriteAction.image = UIImage(named: "Group-136")
        }
        
        if chronometerActionTitle == "Chronos" {
            chronometerAction.image = UIImage(named: "Group-134")
            
        }
        
        if chronometerActionTitle == "UnChronos" {
            
            chronometerAction.image = UIImage(named: "Group-135")
        }
        

        favoriteAction.backgroundColor = .init(named: "backgroundOne")
        chronometerAction.backgroundColor = .init(named: "backgroundOne")

        let action = UISwipeActionsConfiguration(actions: [chronometerAction, favoriteAction])
        
        return action
      
       
    }
    
    // Table View Data Souce -> Exercícios
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
           // return searchExercicies.count
            return filterUser.count
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
            cells.nameLabel.text = filterUser[indexPath.row].exercise
//          cells.nameLabel.text = searchExercicies[indexPath.row]
//          cells.assetsImg.image = UIImage(named: searchExercicies[indexPath.row])!
        } else {
            cells.nameLabel.text = lista
        }
        
        return cells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   SomeCellSelected = true
        
        let passa = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        if searching{
            passa?.title = filterUser[indexPath.row].exercise
        }
        else{
            passa?.title = actionsModel.exercisesList[indexPath.row].exercise
        }
            
            if let customCell = tableView.cellForRow(at: indexPath) as? CustomCell,
               let trainningName = customCell.nameLabel.text{
                passa?.nameTrainning = "\(trainningName)"

            self.navigationController?.pushViewController(passa!, animated: true)
            ExercicioView.reloadData()
        }
    }
}




    



