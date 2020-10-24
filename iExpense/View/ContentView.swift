//
//  ContentView.swift
//  iExpense
//
//  Created by 김종원 on 2020/10/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    var amountSum: Int {
        guard expenses.items.count > 0 else { return 0 }
        var sum = 0
        for item in expenses.items {
            sum += item.amount
        }
        return sum
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("$\(item.amount)")
                                .font(.title)
                                .foregroundColor(accentAmount(item.amount))
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Spacer()
                HStack {
                    Text("Total $\(self.amountSum)")
                        .font(.title)
                        .foregroundColor(accentAmount(self.amountSum))
                }
                .padding()
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddExpense = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func accentAmount(_ amount: Int) -> Color {
        if amount > 100 {
            return Color.red
        } else if amount > 10 {
            return Color.yellow
        }
        return Color.black
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
