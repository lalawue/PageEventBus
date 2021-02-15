//
//  SubmitTextField.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit

/** TextField for better text rect
 */
class SubmitTextField: UITextField {
    
    var offset: UIOffset = UIOffset(horizontal: 10, vertical: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + offset.horizontal,
                      y: 0,
                      width: bounds.size.width - 2*offset.horizontal,
                      height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + offset.horizontal,
                      y: 0,
                      width: bounds.size.width - 2*offset.horizontal,
                      height: bounds.size.height)
    }
}
