//
//  ContentView.swift
//  iExpense
//
//  Created by Jae Cho on 3/1/22.
//

import SwiftUI

class User: ObservableObject{
	var firstName = "Bilbo"
	var lastName = "Baggins"
}

struct ContentView: View {
	@StateObject var user = User()
	
    var body: some View {
		 Text("Your name is \(user.firstName) \(user.lastName)")
		 
		 TextField("First Name ",text: $user.firstName)
		 TextField("Last Name ",text: $user.lastName)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
