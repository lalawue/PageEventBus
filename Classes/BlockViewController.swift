//
//  BlockViewController.swift
//  ViewComponent
//
//  Created by tuu on 2021/2/14.
//

import UIKit

/** view controller as view model holder
 */
open class BlockViewContnroller: UIViewController, BlockViewModelHolder {

    /// init view model in viewDidLoad
    public var viewModel: BlockViewModelAgent?
    
    /// find parent event bus when view's window connected
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if view.window != nil {
            findParentAgent()
        }
    }
}
