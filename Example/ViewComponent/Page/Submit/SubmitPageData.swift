//
//  SubmitPageData.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import Foundation

/** submit page event for view model, page model
 */
enum SubmitEvent {
    
    /// for default
    case None
    
    /// input phone
    case DataInput(String, String)
    
    /// collect phone, email output
    case CollectInput
}

/** submit page result for view model, page model
 */
enum SubmitResult {

    /// for default
    case None
    
    /// collect phone output
    case DataCollect(String, String)
}

/** submit page names for view model, page model
 */
struct SubmitNames {
    static let SubmitAgent = "Submit"
    static let PhoneAgent = "Phone"
    static let EmailAgent = "Email"
    static let InfoAgent = "Info"
    static let ResultAgent = "Result"
}
