//
//  TextFieldDelegateProxy.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit

/** for UITextField delegate, as inherit from NSObject
 */
class TextFieldDelegateProxy: NSObject, UITextFieldDelegate {
    
    var changeCallback: ((String) -> Void)?

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let str = NSString(string: textField.text ?? "")
        if let callback = changeCallback {
            callback(str.replacingCharacters(in: range, with: string) as String)
        }
        return true
    }
}

