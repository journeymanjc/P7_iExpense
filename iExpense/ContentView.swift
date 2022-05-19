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

//Need to split the expenses into two sections one for personal and another for business.
/**
 Approach :
 1. figure out how i'm going to separate the data and then worry about presentation.
 1.1 separating the data first by filtering them between personal and business
 1.2 Create a separate list for personal and business in the listview.
 1.3 will need to incex them separately.
 */

struct ContentView: View {
	@StateObject var expenses = Expenses()
	@State private var showingAddExpense = false
	
	//because i can't figure out how to use onDelete with a sublist i'll create 2 new sublists and then remove the appropriate index on each.
	@State var personalExpenses: [ExpenseItem] = []
	@State var businessExpenses: [ExpenseItem] = []

    var body: some View {
		 
		 NavigationView{
			 VStack{
				 List{
					 ForEach(categorizeList(with: "Business")){ item in
						 HStack{
							 VStack(alignment: .leading){
								 Text(item.name)
									 .font(.headline)
								 Text(item.type)
							 }
							 Spacer()
							 MyTextView(amount: item.amount)
							 
						 }
					 }
					 .onDelete(perform: removeItemsBusiness)
				 }
				 .toolbar {
					 Button {
						 showingAddExpense = true
					 } label : {
						 Image(systemName: "plus")
					 }
				 }
				 Spacer()
				 List{
					 ForEach(categorizeList(with: "Personal")){ item in
						 HStack{
							 VStack(alignment: .leading){
								 Text(item.name)
									 .font(.headline)
								 Text(item.type)
							 }
							 Spacer()
							 MyTextView(amount: item.amount)
							 
						 }
					 }
					 .onDelete(perform: removeItemPersonal)
				 }
				 .toolbar {
					 Button {
						 showingAddExpense = true
					 } label : {
						 Image(systemName: "plus")
					 }
				 }
			 }
		 }
		 .sheet(isPresented: $showingAddExpense) {
			 //show an AddView here
			 AddView(expenses: expenses)
		 }
    }
	
	func removeItemsBusiness(at offsets: IndexSet) {
		businessExpenses.remove(atOffsets: offsets)
	}
	func removeItemPersonal(at offsets: IndexSet) {
		personalExpenses.remove(atOffsets: offsets)
	}
	
	func categorizeList(with category: String) -> [ExpenseItem]{
		let sublist = expenses.items.filter{ $0.type == category }
		
		if category == "Business"{
			businessExpenses = sublist
			return sublist
		}else {
			personalExpenses = sublist
			return sublist
		}
	}

}




struct MyTextView: View{
	@State  var amount : Double
	
	var body: some View{
		switch amount{
		case let amount where amount < 10.0 :
			Text(amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
				.font(.system(size: 10))
				.foregroundColor(.blue)
		case let amount where amount < 100.0 :
			Text(amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
				.font(.system(size: 15))
				.foregroundColor(.orange)
		case let amount where amount >= 100.0 :
			Text(amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
				.font(.system(size: 17))
				.foregroundColor(.red)
		default :
			Text(amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
		}
	}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			 .previewDevice("iPhone 13 Mini")
    }
}
