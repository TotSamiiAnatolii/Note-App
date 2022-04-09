//
//  CoreDateManager.swift
//  Note app
//
//  Created by APPLE on 26.03.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "NoteApp")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext  {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func receiveNotes() -> [NoteApp] {
        let request: NSFetchRequest<NoteApp> = NoteApp.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \NoteApp.id, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            return try viewContext.fetch(request)
        } catch  {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deleteNote(note: NoteApp) {
        viewContext.delete(note)
        save()
    }
    
    func load(complition: (()->())? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            complition?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try  viewContext.save()
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
}
