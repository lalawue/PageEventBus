//
//  BlockViewModel.swift
//
//  Created by lalawue on 2021/2/12.
//

import UIKit

/** view model as event agent
 */
public protocol BlockViewModelAgent {

    /// view did appear
    func viewDidLoad()
    
    /// view did layout
    func viewDidLayout()

    /// view appear
    func viewAppear()

    /// view disappear
    func viewDisappear()
}

/** view model holding by view or view controller
 */
public protocol BlockViewModelHolder {
    
    /// holding view model
    var viewModel: BlockViewModelAgent? { get set }
}

/** event agent holding by view
 */
open class BlockViewModel<V:UIView,E,R>: BlockEventAgent<E,R>, BlockViewModelAgent {
    
    /// event agent holder
    public unowned let view: V

    /// bind with view
    /// - parameter view: bind with view
    public init(view: V) {
        self.view = view
        super.init(holder: view)
    }
}
