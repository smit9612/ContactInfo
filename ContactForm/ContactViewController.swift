//
//  ViewController.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-18.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import UIKit

extension String {
    
}

enum PlaceholderString: String, CaseIterable {
    case firstName = "FirstName"
    case lastName = "LastName"
    case dob = "DOB"
}

final class ContactViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var contactViewModel: ContactViewModel!
    private var contactDataProvider: ContactDataProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentInsetAdjustmentBehavior = .never
        contactViewModel = ContactViewModel()
        contactDataProvider = ContactDataProvider()
        configureStackView()
    }
    @IBAction func saveClicked(_ sender: Any) {
        //Validate all textFields and save contact info into coredata.
        
    }
}

// MARK: - Private methods
extension ContactViewController {
    
    private func configureStackView() {
        contactViewModel.stackableItems.forEach {
            switch $0 {
            case .firstName:
                addTextField(placeHolder: PlaceholderString.firstName.rawValue)
            case .lastName:
                addTextField(placeHolder: PlaceholderString.lastName.rawValue)
            case .dob:
                addTextField(placeHolder: PlaceholderString.dob.rawValue)
            }
        }
    }
    
    private func addTextField(placeHolder: String) {
        
        let inputView = SPInputView.loadFromNib()
        inputView.textField.placeholder = placeHolder
        inputView.textField.delegate = self
        stackView.addArrangedSubview(UIView.createView(withSubview: inputView, edgeInsets: .standard))
    }
    
    private func inputViewFor(placeholder: String?) -> SPInputView? {
        guard let placeHolder = placeholder else {
            return nil
        }
        return stackView.arrangedSubviews.compactMap {
            guard let inputView: SPInputView = $0.subviews.first as? SPInputView, inputView.textField.placeholder == placeholder else {
                return nil
            }
            return inputView
        }.first
    }
    
    private func resetStackView() {
        
    }
}

// MARK: -  UITextFieldDelegate
extension ContactViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let inputView = inputViewFor(placeholder: textField.placeholder) else {
            return true
        }
        inputView.showError = false
        return true
    }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let inputView = inputViewFor(placeholder: textField.placeholder) else {
            return
        }
        do {
            if textField.placeholder == PlaceholderString.firstName.rawValue {
                contactDataProvider?.firstName = try inputView.textField.validatedText(validationType: .firstname)
            }
            if textField.placeholder == PlaceholderString.lastName.rawValue {
                contactDataProvider?.lastName = try inputView.textField.validatedText(validationType: .lastname)
            }
            if textField.placeholder == PlaceholderString.dob.rawValue {
                contactDataProvider?.dob = try inputView.textField.validatedText(validationType: .username)
            }
            
        } catch(let error) {
            if let error: ValidationError = error as? ValidationError {
                inputView.showError(localizedMessage: error.message)
            }
        }
    }
}

// MARK: - UIEdgeInsets
extension UIEdgeInsets {
    
    fileprivate static let top: UIEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: -5, right: -16)
    fileprivate static let bottom: UIEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: -20, right: -16)
    fileprivate static let standard: UIEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: -5, right: -16)
}
