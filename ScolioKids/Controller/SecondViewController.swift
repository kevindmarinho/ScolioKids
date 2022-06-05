//
//  SecondViewController.swift
//  ScolioKids
//
//  Created by Anne Victoria Batista Auzier on 31/05/22.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var SelectionButton: UIBarButtonItem!
    @IBOutlet weak var ExercicioView: UITableView!
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "backgroundOficial")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    //Search

    var searchExercicies = [String]()
    var searching = false
    
    // TableCell

    let exercises = [
        "Lombar",
        "Cervical"
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchExercicies.count
        } else {
            return exercises.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = ExercicioView.dequeueReusableCell(withIdentifier: "customcell") as! CustomCell
        
        let lista = exercises[indexPath.row]
        
        cells.nameLabel?.text = lista
//        cells.assetsImg.image = UIImage(named: lista)
        
        if searching {
            cells.nameLabel.text = searchExercicies[indexPath.row]
//          cells.assetsImg.image = UIImage(named: searchExercicies[indexPath.row])!
        } else {
            cells.nameLabel.text = exercises[indexPath.row]
        }
        if cells.isSelected {
            SomeCellSelected = true
        } else {
            SomeCellSelected = false
        }
        
        return cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SomeCellSelected = true
        let passa = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func modifyBarButtonTitle() {
            isCellSelected = true
            SelectionButton.title = "OK"
        }
}


    



