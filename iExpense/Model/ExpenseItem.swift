//
//  ExpenseItem.swift
//  iExpense
//
//  Created by 김종원 on 2020/10/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
