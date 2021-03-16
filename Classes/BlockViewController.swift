//
//  BlockViewController.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit

/** view controller as view model holder
 */
open class BlockViewContnroller: UIViewController, BlockViewModelHolder {

    /// init view model in viewDidLoad
    public var viewModel: BlockViewModelAgent?

    /// create view model in viewDidLoad
    public var viewModelCreator: ((UIViewController) -> BlockViewModelAgent?)? = nil
    
    /// for create view model after view loaded into memory
    open override func viewDidLoad() {
        super.viewDidLoad()
        if let creator = viewModelCreator {
            viewModel = creator(self)
        }
    }
    
    /// find parent event bus when view's window connected
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if view.window != nil {
            findParentAgent()
        }
        viewModel?.viewAppear()
    }

    /// view disappear to view model
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.viewDisappear()
    }
}
