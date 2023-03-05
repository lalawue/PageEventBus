//
//  BlockAgentDetacher.swift
//  PageEventBus
//
//  Created by lalawue on 2023/3/5.
//

import Foundation

var nsobject_block_model_holder_detacher_key = UInt8(0)

extension NSObject {
    
    /// NSObject runtime property
    fileprivate var block_model_holder_detacher: Any? {
        get {
            return objc_getAssociatedObject(self, &nsobject_block_model_holder_detacher_key)
        }
        set {
            objc_setAssociatedObject(self,
                                     &nsobject_block_model_holder_detacher_key,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

/// internal protocol erase typed infomation
protocol AgentDetatchProtocol: AnyObject {
    func disconnectBus()
}

/// agent auto detach evnt bus when holder dealloc
/// - when holder dealloc, also means detacher dealloc
/// - if agent still alive, means encounter retain circle (memory leaks) most of the time
class BlockAgentDetacher {

    private weak var agent: AgentDetatchProtocol?
    private let agentName: String
    private let holderName: String
    
    deinit {
#if DEBUG
        let holderName = self.holderName
        let agentName = self.agentName
        DispatchQueue.global(qos: .background)
            .asyncAfter(deadline: .now() + .milliseconds(500), execute: { [weak agent] in
                if agent != nil {
                    fatalError("[BlockModelWatchDog] '\(holderName)'s agent still alive: \(agentName)")
                }
            })
#else
        agent?.disconnectBus()
#endif
    }
    
    private init(holder: NSObject, agent: AgentDetatchProtocol) {
        self.agent = agent
        self.agentName = String(describing: agent)
        self.holderName = String(describing: holder)
    }
    
    static func install(holder: NSObject, agent: AgentDetatchProtocol) {
        let detacher = BlockAgentDetacher(holder: holder, agent: agent)
        holder.block_model_holder_detacher = detacher
    }
}
