//
//  SPTextField.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-18.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import UIKit

final class SPInputView: UIView {

    @IBOutlet weak var textField: HoshiTextField!

    @IBOutlet weak var errorLabel: UILabel!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var showError: Bool! {
        didSet {
            errorLabel.isHidden = !showError
            textField.borderInactiveColor = showError ? .red : UIColor.lightGray
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        showError = false
    }

    func showError(localizedMessage: String) {
        showError = true
        errorLabel.text = localizedMessage
    }
}
