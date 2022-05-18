//
//  ContentView.swift
//  iExpense
//
//  Created by Jae Cho on 3/1/22.
//

import SwiftUI

struct SecondView: View{
	@Environment(\.dismiss) var dismiss
	let name: String
	
	var body: some View{
		Button(name){
			dismiss()
		}
	}
}

struct ContentView: View {
	@State private var showingSheet = false
	
    var body: some View {
		 Button("Show Sheet"){
			 showingSheet.toggle()
		 }
		 .sheet(isPresented: $showingSheet) {
			 SecondView(name: "Jae Cho")
		 }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			 .previewDevice("iPhone 13 Mini")
    }
}
