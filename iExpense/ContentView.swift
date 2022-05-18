//
//  ContentView.swift
//  iExpense
//
//  Created by Jae Cho on 3/1/22.
//

import SwiftUI



struct ContentView: View {
	//@State private var tapCount = 0
	@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
	
    var body: some View {
		 Button("Tap count :\(tapCount)"){
			 tapCount += 1
			 UserDefaults.standard.set(self.tapCount, forKey: "Tap")
		 }
		 
    }
	

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			 .previewDevice("iPhone 13 Mini")
    }
}
