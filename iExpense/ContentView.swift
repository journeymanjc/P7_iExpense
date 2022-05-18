//
//  ContentView.swift
//  iExpense
//
//  Created by Jae Cho on 3/1/22.
//

import SwiftUI


struct ExpenseItem : Identifiable{
	let id = UUID()
	let name : String
	let type : String
	let amount : Double
}

class Expenses: ObservableObject {
	@Published var items = [ExpenseItem]()
}

struct ContentView: View {
	@StateObject var expenses = Expenses()
	
    var body: some View {
		 NavigationView{
			 List{
				 ForEach(expenses.items){ item in
					 Text(item.name)
				 }
				 .onDelete(perform: removeItems)
			 }
			 .toolbar {
				 Button {
					 let expense = ExpenseItem(name: "TEST", type: "Personal", amount: 5)
					 expenses.items.append(expense)
				 } label : {
					 Image(systemName: "plus")
				 }
			 }
		 }
    }
	
	func removeItems(at offsets: IndexSet) {
		expenses.items.remove(atOffsets: offsets)
	}

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			 .previewDevice("iPhone 13 Mini")
    }
}
