//
//  Model.swift
//  MovieApp
//
//  Created by Gustavo Souto Pereira on 27/06/25.
//

import Foundation
import CoreData

protocol Model {
    
}

extension Model where Self: NSManagedObject {
    
    func save() throws {
        try CoreDataProvider.shared.viewContext.save()
    }
    
    func delete() throws {
        CoreDataProvider.shared.viewContext.delete(self)
        try save()
    }
    
    static var all: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: String(describing: self))
        request.sortDescriptors = []
        return request
    }
}
