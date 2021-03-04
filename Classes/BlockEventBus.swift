//
//  BlockEventBus.swift
//
//  Created by lalawue on 2021/2/12.
//

import Foundation

/** agent can receive event, then provide result, also have data interface for business logic
 */
open class BlockEventAgent<E,R> {
    
    /// event bus life equal or long than agent
    public unowned var bus: BlockEventBus<E,R>?
    
    /// data setter
    public var data: Any? {
        didSet {
            updateData(data: data)
        }
    }
    
    /// agent name for result identity
    open func agentName() -> String {
        return "\(self)"
    }
    
    /// did receive event type, return R?
    open func didReceiveEvent(event: E) -> R? {
        return nil
    }
    
    /// bus connected callback
    open func busConnected() {
        #if DEBUG
        NSLog("bus connected \(self)")
        #endif
    }
    
    /// data update interface, do not call directly
    /// - parameter data: any struct or class
    open func updateData(data: Any?) {
    }

    /// view appear for view model
    open func viewAppear() {
    }

    // view disappear for view model
    open func viewDisappear() {
    }
}

/** event bus for dispatching event to agents
 */
public class BlockEventBus<E,R> {

    /// event receiver
    private var agents = NSHashTable<BlockEventAgent<E,R>>.weakObjects()
    
    /// add agent to receive event
    public func addAgent(agent: BlockEventAgent<E,R>) {
        agents.add(agent)
        agent.busConnected()
    }
    
    /// send event to agents, collect results
    @discardableResult
    public func sendEvent(event: E) -> [String:R] {
        let arr = agents.allObjects
        guard arr.count > 0 else {
            return [:]
        }
        var rets: [String:R] = [:]
        for agent in arr {
            if let ret = agent.didReceiveEvent(event: event) {
                rets[agent.agentName()] = ret
            }
        }
        return rets
    }
}

