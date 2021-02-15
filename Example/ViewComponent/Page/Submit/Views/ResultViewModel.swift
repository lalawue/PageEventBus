//
//  ResultViewModel.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/15.
//

import UIKit
import PageEventBus

class ResultViewModel: BlockViewModel<ResultView, SubmitEvent, SubmitResult> {
    
    override func agentName() -> String {
        return SubmitNames.ResultAgent
    }

    /// update title
    override func updateData(data: Any?) {
        guard let title = data as? String else {
            return
        }
        view.titleLabel.text = title
    }
    
    /// when bus connected ( move to window), collect input for other child controller
    override func busConnected() {
        guard let rets = bus?.sendEvent(event: .CollectInput) else {
            return
        }
        let arr = [rets[SubmitNames.PhoneAgent],
                   rets[SubmitNames.EmailAgent]]
        var phoneStr = ""
        var emailStr = ""
        for ret in arr {
            switch ret {
            case .DataCollect(let flag, let data):
                if flag == "Phone" {
                    phoneStr = data
                } else {
                    emailStr = data
                }
            default:
                break
            }
        }
        if phoneStr.count > 0 {
            view.firstLabel.text = "Phone: " + phoneStr
        }
        if emailStr.count > 0 {
            view.secondLabel.text = "Email: " + emailStr
        }
    }
}
