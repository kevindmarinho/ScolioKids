//
//  actionsModel.swift
//  ScolioKids
//
//  Created by Dessana Santos on 17/06/22.
//

import Foundation
import UIKit
import CoreData

class ActionsModel {
    
    static let shared = ActionsModel()
    
    var exercisesList: [Exercises] = ["Aviãozinho", "Prancha Lateral"].compactMap({Exercises(exercise: $0, isFavorited: false, isChronometer: false)})
    
    
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
    
    
    //FAVORITES
    func savingToFavorites(index: Int) {

        guard let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context) else { return }
        
        let favoriteExercise = NSManagedObject(entity: entity, insertInto: context)
        
        favoriteExercise.setValue(exercisesList[index].exercise, forKey: "favoritesName")
        favoriteExercise.setValue(true, forKey: "isFavorited")
        
        
        do {
            try context.save()
            favorites.append(favoriteExercise)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFromFavorites(index: Int) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        
        //3
        request.predicate = NSPredicate(format: "favoritesName = %@", "\(exercisesList[index].exercise)")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject]
            {
                context.delete(data)
                
                do {
                    try context.save()
                }
                catch {
                    // Handle Error
                }
            }
            
        } catch {
            print("Failed")
        }
    }
    
    func changeFavoritesTitleName(index: Int) -> String {
        
        var favoriteActionTitle = "Favorite"
        
        let favoritesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        
        favoritesRequest.predicate = NSPredicate(format: "favoritesName = %@", "\(exercisesList[index].exercise)")
        
        favoritesRequest.returnsObjectsAsFaults = false
        
        do {
            let favorites = try context.fetch(favoritesRequest)
            
            for data in favorites as! [NSManagedObject]{
                let boolean = data.value(forKey: "isFavorited") as! Bool
                
                if boolean == true {
                    favoriteActionTitle = "Unfavorite"
                }
                do {
                    try context.save()
                }
                catch {
                    // Handle Error
                }
            }
        } catch {
            print("Failed")
        }
        
        return favoriteActionTitle
    }
    
    func favoritesFetchRequest() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        do {
            favorites = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    // CRONOMETERO
    func savingToChronometer(index: Int) {
        
//   let entity = NSEntityDescription.entity(forEntityName: "Chronometer", in: context)!
        if let entity = NSEntityDescription.entity(forEntityName: "Chronometer", in: context) {

            let chronometerExercise = NSManagedObject(entity: entity, insertInto: context)

            chronometerExercise.setValue(exercisesList[index].exercise, forKey: "chronometerName")
            chronometerExercise.setValue(true, forKey: "isFavorited")
            
            do {
                try context.save()
                chronometer.append(chronometerExercise)
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteFromChronometer(index: Int){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Chronometer")
        //3
        request.predicate = NSPredicate(format: "chronometerName = %@", "\(exercisesList[index].exercise)")
        request.returnsObjectsAsFaults = false
        do {
            //4
            let result = try context.fetch(request)
            
            //5
            for data in result as! [NSManagedObject]
            {
                //6
                context.delete(data)
                //
                do {
                    try context.save()
                }
                catch {
                    // Handle Error
                }
            }
            
        } catch {
            print("Failed")
        }
    }
    
    func changeChronometerTitleName(index: Int) -> String {
        
        var chronometerActionTitle = "Chronos"
        
        let chronometerRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chronometer")
        
        chronometerRequest.predicate = NSPredicate(format: "chronometerName = %@", "\(exercisesList[index].exercise)")
     
        chronometerRequest.returnsObjectsAsFaults = false

        do {
            let chronometer = try context.fetch(chronometerRequest)
            for data in chronometer as! [NSManagedObject]{
                let boolean = data.value(forKey: "isFavorited") as! Bool
    
                if boolean == true {
                    
                    chronometerActionTitle = "UnChronos"
                }
                do {
                    try context.save()
                }
                catch {
                    // Handle Error
                }
            }
        } catch {
            print("Failed")
        }
        
        return chronometerActionTitle
    }
    
    func chronometerFetchRequest() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Chronometer")

        do {
            chronometer = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
