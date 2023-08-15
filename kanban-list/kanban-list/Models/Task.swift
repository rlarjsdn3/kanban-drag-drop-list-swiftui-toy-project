//
//  Task.swift
//  kanban-list
//
//  Created by 김건우 on 2023/08/15.
//

import Foundation

struct Task: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var status: Status
}

enum Status {
    case todo
    case working
    case completed
}
