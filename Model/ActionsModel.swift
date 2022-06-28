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
        
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context)!
        
        let favoriteExercise = NSManagedObject(entity: entity, insertInto: context)
        
        // 3
        favoriteExercise.setValue(exercisesList[index].exercise, forKey: "favoritesName")
        favoriteExercise.setValue(true, forKey: "isFavorited")
        
        
        do {
            try context.save()
            favorites.append(favoriteExercise)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFromFavorites(index: Int){
     
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
    
    // CRONOMETERO
    func savingToChronometer(index: Int) {

        let entity = NSEntityDescription.entity(forEntityName: "Chronometer", in: context)!
        
        let chronometerExercise = NSManagedObject(entity: entity, insertInto: context)
        // 3
        chronometerExercise.setValue(exercisesList[index].exercise, forKey: "chronometerName")
        chronometerExercise.setValue(true, forKey: "isFavorited")
        
        do {
            try context.save()
            chronometer.append(chronometerExercise)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
}
