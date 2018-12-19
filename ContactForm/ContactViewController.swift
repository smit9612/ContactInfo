//
//  ViewController.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-18.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import UIKit

final class ContactViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var contactViewModel: ContactViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentInsetAdjustmentBehavior = .never
        contactViewModel = ContactViewModel()
        configureStackView()
    }
}

// MARK: - Private methods
extension ContactViewController {
    
    private func configureStackView() {
        contactViewModel.stackableItems.forEach {
            switch $0 {
            case .firstName:
                addTextField(placeHolder: "FirstName")
            case .lastName:
                addTextField(placeHolder: "LastName")
            case .dob:
                addTextField(placeHolder: "dob")
            }
        }
    }
    
    private func addTextField(placeHolder: String) {
        
        let inputView = SPInputView.loadFromNib()
        inputView.textField.placeholder = placeHolder
        stackView.addArrangedSubview(UIView.createView(withSubview: inputView, edgeInsets: .badge))
    }

}

// MARK: - UIEdgeInsets
extension UIEdgeInsets {
    
    fileprivate static let badge: UIEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: -5, right: -16)
}
