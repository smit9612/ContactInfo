// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ContactInfo.swift instead.

import Foundation
import CoreData

public enum ContactInfoAttributes: String {
    case dob = "dob"
    case firstName = "firstName"
    case lastName = "lastName"
}

public enum ContactInfoRelationships: String {
    case relationship = "relationship"
}

open class _ContactInfo: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "ContactInfo"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _ContactInfo.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var dob: String?

    @NSManaged open
    var firstName: String?

    @NSManaged open
    var lastName: String?

    // MARK: - Relationships

    @NSManaged open
    var relationship: NSSet

    open func relationshipSet() -> NSMutableSet {
        return self.relationship.mutableCopy() as! NSMutableSet
    }

}

extension _ContactInfo {

    open func addRelationship(_ objects: NSSet) {
        let mutable = self.relationship.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.relationship = mutable.copy() as! NSSet
    }

    open func removeRelationship(_ objects: NSSet) {
        let mutable = self.relationship.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.relationship = mutable.copy() as! NSSet
    }

    open func addRelationshipObject(_ value: Address) {
        let mutable = self.relationship.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.relationship = mutable.copy() as! NSSet
    }

    open func removeRelationshipObject(_ value: Address) {
        let mutable = self.relationship.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.relationship = mutable.copy() as! NSSet
    }

}

