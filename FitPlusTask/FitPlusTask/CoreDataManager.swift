//
//  CoreDataManager.swift
//  SampleTableDemo
//
//  Created by venkata rama kishore arimilli on 09/02/21.
//  Copyright © 2021 venkata rama kishore arimilli. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var managedContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FitPlusData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Core Data un resolved error \((error as NSError).userInfo)")
            }
            
        }
    }
    private init(){}
    

    
}
