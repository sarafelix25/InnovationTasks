//
//  Task.swift
//  InnovationTasks
//
//  Created by sara.batista.d.felix on 07/07/21.
//

import Foundation

struct Task {
    var id = UUID()
    var name: String = ""
    var date: Date = Date()
    var category: Category = Category(name: "Marketing", color: .black)
}
