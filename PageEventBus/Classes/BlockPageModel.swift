//
//  BlockPageModel.swift
//
//  Created by lalawue on 2021/2/13.
//

import UIKit

/** event agent holding by view controller
 */
open class BlockPageModel<C:UIViewController,E,R>: BlockEventAgent<E,R>, BlockViewModelAgent {
    
    /// event agent holder
    public unowned let controller: C
    
    /// bind with controller
    /// - parameter controller: bind with controller
    public init(controller: C) {
        self.controller = controller
        super.init(holder: controller)
    }
}
