//
//  BlockPageModel.swift
//
//  Created by lalawue on 2021/2/13.
//

import UIKit

/** event agent holding by view controller
 */
open class BlockPageModel<C:UIViewController&BlockViewModelHolder,V:UIView,E,R>: BlockViewModel<V,E,R> {
    
    /// event agent holder
    public unowned let controller: C
    
    /// page event bus
    private let pageBus: BlockEventBus<E,R>?
    
    /// bind with controller
    /// - parameter controller: bind with controller
    /// - parameter initBus: when true, create event bus; false to use other's event bus
    public init(controller: C, initBus: Bool = true) {
        self.controller = controller
        if initBus {
            self.pageBus = BlockEventBus<E,R>()
        } else {
            self.pageBus = nil
        }
        super.init(view: controller.view as! V)
        self.bus = pageBus
        if pageBus != nil {
            pageBus!.addAgent(agent: self)
        }
        // when self.bus == nil, trigger BlockViewModelHolder's findParentAgent()
        // after view.window != nil
    }
    
    public override func findBus() {
        if pageBus == nil {
            super.findBus()
        }
    }
}
