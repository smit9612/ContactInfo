//
//  ItemStackable.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-18.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import Foundation

protocol ItemStackable {
    
    associatedtype StackableItem
    
    var stackableItems: [StackableItem]! { get }
}
