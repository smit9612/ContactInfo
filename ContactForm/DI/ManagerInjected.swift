//
//  ManagerInjected.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-19.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import Foundation

protocol ManagerInjected {}

extension ManagerInjected {
    
    var coreDataManager: CoreDataManagerProtocol {
        return ManagerInjector.coreDataManager
    }
}

struct ManagerInjector {
    static var coreDataManager: CoreDataManagerProtocol = CoreDataManager() as! CoreDataManagerProtocol
}
