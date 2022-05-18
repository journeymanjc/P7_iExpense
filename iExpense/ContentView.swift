//
//  ContentView.swift
//  iExpense
//
//  Created by Jae Cho on 3/1/22.
//

import SwiftUI



struct ContentView: View {
	@State private var numbers = [Int]()
	@State private var currentNumber = 1
	
    var body: some View {
		 NavigationView{
			 VStack{
				 List {
					 ForEach(numbers, id:\.self){
						 Text("Row \($0)")
					 }
					 .onDelete(perform: removeRows)
				 }
				 Button("Add Number"){
					 numbers.append(currentNumber)
					 currentNumber += 1
				 }
			 }
			 .toolbar{
				 EditButton()
			 }
		 }
		 
    }
	
	func removeRows(at offset: IndexSet) {
		numbers.remove(atOffsets: offset)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			 .previewDevice("iPhone 13 Mini")
    }
}
