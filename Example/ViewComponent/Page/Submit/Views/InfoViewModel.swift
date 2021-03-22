//
//  InfoViewModel.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit
import PageEventBus

/** info view model
 */
class InfoViewModel: BlockViewModel<InfoView, SubmitEvent, SubmitResult> {
    
    var placeHolder: String = ""
    var phone: String = ""
    var email: String = ""
    
    override func agentName() -> String {
        return SubmitNames.InfoAgent
    }
    
    override func updateData(data: Any?) {
        guard let str = data as? String else {
            return
        }
        connectBus()
        placeHolder = str
        updateInfo()
    }
    
    override func didReceiveEvent(event: SubmitEvent) -> SubmitResult? {
        switch event {
        case .DataInput(let flag, let data):
            if flag == "Phone" {
                self.phone = data
            } else {
                self.email = data
            }
            updateInfo()
        default:
            break
        }
        return nil
    }
    
    fileprivate func updateInfo() {
        var str = placeHolder
        if phone.count > 0 {
            if email.count > 0 {
                str = "Hello, " + phone
            } else {
                str = "Please fill email"
            }
        } else if email.count > 0 {
            str = "Please fill phone"
        }
        view.titleLabel.text = str
        view.setNeedsLayout()
    }
}

