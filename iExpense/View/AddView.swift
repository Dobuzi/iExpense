//
//  AddView.swift
//  iExpense
//
//  Created by 김종원 on 2020/10/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker(selection: $type, label: Text("Type")) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                HStack {
                    Text("$")
                    Spacer()
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button(action: {
                guard self.name.count > 0 else {
                    alertTitle = "Name error"
                    alertMessage = "Please enter the name"
                    showingAlert = true
                    return
                }
                if let amount = Int(self.amount) {
                    let expense = ExpenseItem(name: self.name, type: self.type, amount: Int(amount))
                    self.expenses.items.append(expense)
                } else {
                    alertTitle = "Amount Error"
                    alertMessage = "Amount has to be a number"
                    self.showingAlert = true
                }
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            }))
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
