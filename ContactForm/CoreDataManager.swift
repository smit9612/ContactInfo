//
//  CoreDataManager.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-18.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    
    func deleteManagedObjects(_ objects: [NSManagedObject])
    func deleteAllRecords(from entity: String)
    func saveContact(contactDataProvider: ContactDataProvider)
    func fetchContacts() -> [ContactDataProvider]?
}

/// Core Data stack
final class CoreDataManager: NSObject {

    private lazy var documentDirectoryURL: URL? = {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "")
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelURL = Bundle.main.url(forResource: "ContactForm", withExtension: "momd"), let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            return nil
        }
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let mom = managedObjectModel, let docmentURL = documentDirectoryURL else { return nil }
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let url = docmentURL.appendingPathComponent("ContactForm.sqlite")
        do {
            let options = [NSSQLitePragmasOption: ["journal_mode": "DELETE"], NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true] as [String: Any]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            abort()
        }
        
        return coordinator
    }()
    
    /// The managedObjectContext returns the managed object context for the application.
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}

// MARK: - CoreDataProvider
extension CoreDataManager: CoreDataManagerProtocol {
    
    func fetchContacts() -> [ContactDataProvider]? {
        var contactDataProviders = [ContactDataProvider]()
        for data in fetchObjects(for: "ContactInfo") as! [NSManagedObject] {
            var contactDataProvider = ContactDataProvider()
            contactDataProvider.firstName = data.value(forKey: "firstName") as? String
            contactDataProvider.lastName = data.value(forKey: "lastName") as? String
            contactDataProvider.dob = data.value(forKey: "dob") as? String
            contactDataProviders.append(contactDataProvider)
        }
        return contactDataProviders
    }
    
    
    func saveContact(contactDataProvider: ContactDataProvider) {
        let contactInfo = ContactInfo(context: managedObjectContext)
        contactInfo.firstName = contactDataProvider.firstName
        contactInfo.lastName = contactDataProvider.lastName
        contactInfo.dob = contactDataProvider.dob
        saveContext()
    }
    
    
    /// The saveContext saves the managedObjectContext changes
    func saveContext() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
        } catch {
            abort()
        }
    }
    
    /// The delete function deletes the managed objects from the managed object context
    func deleteManagedObjects(_ objects: [NSManagedObject]) {
        objects.forEach { managedObjectContext.delete($0) }
        saveContext()
    }
    
    func deleteAllRecords(from entity: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try persistentStoreCoordinator?.execute(deleteRequest, with: managedObjectContext)
        } catch {
            abort()
        }
    }
    
    
}

// MARK: - Private Methods
extension CoreDataManager {
    /// Returns the fetched objects of the given entity for the given parameters, sorted by an array of sort descriptors.
    ///
    /// - Parameters:
    ///   - entity: entity name
    ///   - sortDescriptors: an array of sort descriptors.
    ///   - predicate: The fetch predicate (optional, default is nil).
    ///   - fetchLimit: the number of items to be fetched (optional, default is no limit).
    /// - Returns: A optional array of objects of the current NSManagedObject subclass.
    
    private func fetchObjects(for entity: String, sortedBy sortDescriptors: [NSSortDescriptor]? = nil,
                      predicate: NSPredicate? = nil,
                      fetchLimit: Int = 1) -> NSArray? {
        let request = fetchRequest(for: entity, predicate: predicate, sortDescriptors: sortDescriptors, fetchLimit: fetchLimit)
        guard let managedObjects = try? managedObjectContext.fetch(request) as? [NSManagedObject] else { return nil }
        return managedObjects as? NSArray
    }
    
    private func fetchRequest(for entityName: String, predicate: NSPredicate? = nil,
                              sortDescriptors: [NSSortDescriptor]?,
                              fetchLimit: Int = 1) -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request
    }
}
