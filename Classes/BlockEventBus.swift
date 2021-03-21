//
//  BlockEventBus.swift
//
//  Created by lalawue on 2021/2/12.
//

import Foundation

/** agent can receive event, then provide result, also have data interface for business logic
 */
open class BlockEventAgent<E,R> {
    
    /// data setter
    public var data: Any? {
        didSet {
            updateData(data: data)
        }
    }
    
    /// data update interface, do not call directly
    /// - parameter data: any struct or class
    open func updateData(data: Any?) {
    }
    
    // MARK: -
    
    /// event bus
    public var bus: BlockEventBus<E,R>?
    
    /// bus name, default to event/response type
    open var busName: String {
        return "\(BlockEventBus<E,R>.self)"
    }
    
    /// connect to event bus, or create it
    @discardableResult
    open func connectBus() -> Bool {
        guard bus == nil else {
            return true
        }
        let ret = BlockEventBusManager.getBus(busName)
        if ret.exist {
            if let ebus = ret.bus as? BlockEventBus<E,R> {
                bus = ebus
            } else {
                return false
            }
        } else {
            bus = BlockEventBus<E,R>()
            BlockEventBusManager.setBus(bus!, busName)
        }
        bus!.addAgent(agent: self)
        return true
    }
    
    /// disconnect to event bus
    open func disconnectBus() {
        bus?.removeAget(agent: self)
        bus = nil
    }
    
    // MARK: -
    
    /// agent name for result identity
    open func agentName() -> String {
        return "\(self)"
    }
    
    /// did receive event type, return R?
    open func didReceiveEvent(event: E) -> R? {
        return nil
    }
    
    // MARK: -
    
    /// view did load for ppublic age modpublic el
    open func viewDidLoad() {
    }

    /// view did layout
    open func viewDidLayout() {
    }

    /// view appear for vpublic iew modpublic el
    open func viewAppear() {
    }

    // view disappeapublic r for view model
    open func viewDisappear() {
    }
}

/** event bus for dispatching event to agents
 */
public class BlockEventBus<E,R> {

    /// event receiver
    private var agents = NSHashTable<BlockEventAgent<E,R>>.weakObjects()
    
    /// add agent to receive event
    fileprivate func addAgent(agent: BlockEventAgent<E,R>) {
        agents.add(agent)
    }
    
    /// remove agent from bus
    fileprivate func removeAget(agent: BlockEventAgent<E,R>) {
        agents.remove(agent)
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

/** holding event bus with name
 */
fileprivate class BlockEventBusManager {

    /// holding event bus
    static private var busMap = NSMapTable<NSString,AnyObject>.strongToWeakObjects()
    
    /// only one instance
    private init() {
    }

    /// get event bus with name, return (exist, bus)
    static func getBus(_ name: String) -> (exist:Bool, bus:AnyObject?) {
        let bus = busMap.object(forKey: NSString(string: name))
        if bus == nil {
            return (false, nil)
        }
        return (true, bus)
    }
    
    /// set event bus with name
    static func setBus(_ bus: AnyObject, _ name: String) {
        let `name` = NSString(string: name)
        if busMap.object(forKey: name) == nil {
            busMap.setObject(bus, forKey: name)
        }
    }
}

