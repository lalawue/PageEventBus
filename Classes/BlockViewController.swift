//
//  BlockViewController.swift
//
//  Created by lalawue on 2021/2/14.
//

import UIKit

/** view controller as view model holder
 */
open class BlockViewContnroller: UIViewController {

    /// init page model in viewDidLoad
    public var pageModel: BlockViewModelAgent?
    
    /// view model did load
    open override func viewDidLoad() {
        super.viewDidLoad()
        pageModel?.viewDidLoad()
    }

    /// page model did layout
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageModel?.viewDidLayout()
    }
    
    /// page model appear
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageModel?.viewAppear()
    }

    /// page model disappear
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pageModel?.viewDisappear()
    }
}
