//
//  BlockViewModel.swift
//
//  Created by lalawue on 2021/2/12.
//

import UIKit

/** view model as event agent
 */
public protocol BlockViewModelAgent {

    /// get typed event bus instance
    func getBus() -> AnyObject?
    
    /// find and connect to parent's event bus
    func findBus()

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

extension BlockViewModelHolder {

    /// find parent agent through responder chain
    public func findParentAgent() {
        guard let model = viewModel, model.getBus() == nil else {
            return
        }
        model.findBus()
    }
}

/** event agent holding by view
 */
open class BlockViewModel<V:UIView,E,R>: BlockEventAgent<E,R>, BlockViewModelAgent {
    
    /// event agent holder
    public unowned let view: V

    /// not found event bus flag
    private var notFoundBus = false
    
    // MARK: -
    
    /// bind with view
    /// - parameter view: bind with view
    public init(view: V) {
        self.view = view
    }
    
    /// get bus instance
    public func getBus() -> AnyObject? {
        return bus
    }
    
    /// find event bus from responder chain
    public func findBus() {
        if notFoundBus {
            return
        }
        guard bus == nil && view.window != nil else {
            return
        }
        var responder = view.next
        while let next = responder {
            if let parent = next as? BlockViewModelHolder {
                if let parentModel = parent.viewModel,
                   let bus = parentModel.getBus() as? BlockEventBus<E,R>
                {
                    self.bus = bus
                    bus.addAgent(agent: self)
                    return
                }
            }
            responder = next.next
        }
        notFoundBus = true
    }
}
