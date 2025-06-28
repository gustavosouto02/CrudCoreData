//
//  CoreDataProvider.swift
//  MovieApp
//
//  Created by Gustavo Souto Pereira on 27/06/25.
//

import Foundation
import CoreData

class CoreDataProvider {
    static let shared = CoreDataProvider()
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error{
                fatalError("Unresolved error \(error)")
            }
        }
    }
}
