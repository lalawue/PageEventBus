//
//  NoticeEvent.swift
//  ViewComponent
//
//  Created by lalawue on 2023/2/19.
//

import Foundation

struct NoticeData {
    let context: String
    let title: String
    let contents: [String]
}

enum NoticeRequest {

    case updateNotice(NoticeData)

    /// context
    case fetchNotice(String)
}

enum NoticeResonse {
    
    case fetchNotice(NoticeData)
}
