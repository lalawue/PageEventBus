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
        let ebus = BlockEventBusManager.getBus(busName)
        if ebus != nil {
            if ebus is BlockEventBus<E,R> {
                bus = (ebus as! BlockEventBus<E,R>)
            } else {
                #if DEBUG
                assert(false, "bus type with another name exist !")
                #endif
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

    /// support auto disconnect bus after holder dealloc
    open func supportDetacher() -> Bool {
        return true
    }

    /// agent creation
    /// - parameter holder: which holding agent
    public init(holder: NSObject?) {
        if let `holder` = holder, supportDetacher() {
            BlockAgentDetacher<E,R>.install(holder: holder, agent: self)
        }
    }
    
    // MARK: -
    
    /// view did load
    open func viewDidLoad() {
    }

    /// view did layout
    open func viewDidLayout() {
    }

    /// view appear
    open func viewAppear() {
    }

    // view disappear
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
    public func sendEvent(_ event: E) -> [String:R] {
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
    
    /// send event to agents, collect the very first one response
    /// - parameter from: specify responder's name
    @discardableResult
    public func requestOne(_ event: E, from agentName: String? = nil) -> R? {
        if let `agentName` = agentName {
            return sendEvent(event).filter({ $0.key == agentName }).first?.value
        } else {
            return sendEvent(event).first?.value
        }
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
    static func getBus(_ name: String) -> AnyObject? {
        return busMap.object(forKey: NSString(string: name))
    }
    
    /// set event bus with name
    static func setBus(_ bus: AnyObject, _ name: String) {
        let `name` = NSString(string: name)
        if busMap.object(forKey: name) == nil {
            busMap.setObject(bus, forKey: name)
        }
    }
}
