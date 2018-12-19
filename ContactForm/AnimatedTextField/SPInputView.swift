//
//  SPTextField.swift
//  ContactForm
//
//  Created by smitesh patel on 2018-12-18.
//  Copyright © 2018 smitesh patel. All rights reserved.
//

import UIKit

final class SPInputView: UIView {

    @IBOutlet weak var textField: AkiraTextField!
    
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
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showError = false
    }
    
}
