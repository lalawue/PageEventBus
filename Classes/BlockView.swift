//
//  BlockView.swift
//
//  Created by lalawue on 2021/2/12.
//

import UIKit

/** view as view model holder
 */
open class BlockView: UIView, BlockViewModelHolder {
    
    /// BlockViewModel instance
    public var viewModel: BlockViewModelAgent?

    /// connect view model's event bus when move to window
    open override func didMoveToWindow() {
        if self.window == nil {
            return
        }
        findParentAgent()
    }
}
