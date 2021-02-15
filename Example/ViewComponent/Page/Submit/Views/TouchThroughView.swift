//
//  TouchThroughView.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit

/** view can touch through
 */
class TouchThroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let v = super.hitTest(point, with: event)
        if v == self {
            return nil
        }
        return v
    }
}
