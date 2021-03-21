//
//  PhonePageModel.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit
import PageEventBus

/** model for input phone or email
 */
class InputPageModel: BlockPageModel<InputViewController, SubmitEvent, SubmitResult> {
    
    fileprivate let fieldDelegate = TextFieldDelegateProxy()
        
    fileprivate lazy var field: UITextField = {
        let f = SubmitTextField()
        f.layer.borderWidth = 0.5
        f.layer.borderColor = UIColor.gray.cgColor
        f.autocapitalizationType = .none
        return f
    }()
    
    // MARK: -
    
    override func viewDidLoad() {
        controller.view.addSubview(field)
        
        guard let placeHolder = data as? String else {
            return
        }
        field.placeholder = placeHolder
        if field.delegate == nil {
            field.delegate = fieldDelegate
            fieldDelegate.changeCallback = { [weak self] str in
                guard let `self` = self else {
                    return
                }
                self.bus?.sendEvent(event: .DataInput(placeHolder, str))
            }
        }
        if placeHolder == "Phone" {
            field.keyboardType = .phonePad
        } else {
            field.keyboardType = .emailAddress
        }
    }
    
    override func viewDidLayout() {
        field.frame = CGRect(x: 0, y: 0, width: 180, height: 45)
        let viewSize = controller.view.frame.size
        field.center = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
    }
    
    override func agentName() -> String {
        if field.placeholder == "Phone" {
            return SubmitNames.PhoneAgent
        } else {
            return SubmitNames.EmailAgent
        }
    }
    
    override func didReceiveEvent(event: SubmitEvent) -> SubmitResult? {
        switch event {
        case .CollectInput:
            return .DataCollect(field.placeholder ?? "", field.text ?? "")
        default:
            return nil
        }
    }
}
