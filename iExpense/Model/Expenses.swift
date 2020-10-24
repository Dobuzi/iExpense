//
//  Expenses.swift
//  iExpense
//
//  Created by 김종원 on 2020/10/24.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items) {
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let data = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = data
                return
            }
        }
        
        self.items = []
    }
}
