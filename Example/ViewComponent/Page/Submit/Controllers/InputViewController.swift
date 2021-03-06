//
//  InputViewController.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit
import PageEventBus

/** child view controller for input phonen or email
 */
class InputViewController: BlockViewContnroller {
    
    var viewWillLayoutCallback: ((InputViewController) -> Void)?
    
    override func loadView() {
        self.view = TouchThroughView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let callback = viewWillLayoutCallback {
            callback(self)
        }
    }
}
