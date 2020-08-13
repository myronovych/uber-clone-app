//
//  UITextField.swift
//  Uber-Clone-iOS
//
//  Created by rs on 13.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

extension UITextField {
    func textField(placeholder: String, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.isSecureTextEntry = isSecure
        textField.borderStyle = .none
        return textField
    }
}
