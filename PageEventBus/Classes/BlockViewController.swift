//
//  BlockViewController.swift
//
//  Created by lalawue on 2021/2/14.
//

import UIKit

/** view controller as view model holder
 */
open class BlockViewContnroller: UIViewController, BlockViewModelHolder {

    /// view model interface
    public var viewModel: BlockViewModelAgent?
    
    /// view model did load
    open override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }

    /// page model did layout
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel?.viewDidLayout()
    }
    
    /// page model appear
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewAppear()
    }

    /// page model disappear
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.viewDisappear()
    }
}
