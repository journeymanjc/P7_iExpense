//
//  ContentView.swift
//  iExpense
//
//  Created by Jae Cho on 3/1/22.
//

import SwiftUI


struct ExpenseItem : Identifiable,Codable{
	var id = UUID()
	let name : String
	let type : String
	let amount : Double
}

class Expenses: ObservableObject{
	@Published var items = [ExpenseItem](){
		didSet{
			if let encoded = try? JSONEncoder().encode(items){
				UserDefaults.standard.set(encoded, forKey: "Items")
			}
		}
	}
	init() {
		if let savedItems = UserDefaults.standard.data(forKey: "Items") {
			if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
				items = decodedItems
				return
			}
		}
	}
}

struct ContentView: View {
	@StateObject var expenses = Expenses()
	@State private var showingAddExpense = false
	
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
					 showingAddExpense = true
				 } label : {
					 Image(systemName: "plus")
				 }
			 }
		 }
		 .sheet(isPresented: $showingAddExpense) {
			 //show an AddView here
			 AddView(expenses: expenses)
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
