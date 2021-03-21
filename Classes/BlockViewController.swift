//
//  BlockViewController.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit

/** view controller as view model holder
 */
open class BlockViewContnroller: UIViewController {

    /// init view model in viewDidLoad
    public var pageModel: BlockViewModelAgent?
    
    /// create view model in viewDidLoad
    public var pageModelCreator: ((UIViewController) -> BlockViewModelAgent?)? = nil

    /// for create view model after view loaded into memory
    open override func viewDidLoad() {
        super.viewDidLoad()
        if let creator = pageModelCreator {
            pageModel = creator(self)
        }
        pageModel?.viewDidAppear()
    }
    
    /// find parent event bus when view's window connected
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageModel?.viewAppear()
    }

    /// view disappear to view model
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pageModel?.viewDisappear()
    }
}
