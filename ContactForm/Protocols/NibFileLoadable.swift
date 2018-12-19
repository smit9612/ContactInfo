//
//  NibFileLoadable.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-19.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import Foundation
import UIKit

protocol NibFileLoadable {
    
    static var nib : UINib { get }
}

extension UIView: NibFileLoadable {}

extension NibFileLoadable where Self: UIView {
    
    static var nib : UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}

extension NibFileLoadable where Self: UIView {
    
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}
