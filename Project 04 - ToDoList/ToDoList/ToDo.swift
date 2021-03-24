//
//  ToDo.swift
//  ToDoList
//
//  Created by 이다영 on 2021/03/22.
//

import Foundation

class ToDo {
    var title: String
    var description: String?
    var date: Double?
    var isComplete: Bool
    
    init(title: String, description: String? = nil, date: Double? = nil, isComplete: Bool = false) {
        self.title = title
        self.description = description
        self.date = date
        self.isComplete = isComplete
    }
}
