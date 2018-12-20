//
//  ContactViewmodel.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-18.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import Foundation
import CoreData

struct ContactDataProvider {
    
    var firstName: String?
    var lastName: String?
    var dob: String?
}

struct ContactViewModel: ItemStackable {

    // MARK: - ItemStackable
    enum StackableItem {
        case firstName
        case lastName
        case dob
    }
    
    var stackableItems: [StackableItem]! {
        var items: [StackableItem] = []
    
        items.append(.firstName)
        items.append(.lastName)
        items.append(.dob)

        return items
    }
    
    func saveContact(data: ContactDataProvider) {
        
    }
    
}
