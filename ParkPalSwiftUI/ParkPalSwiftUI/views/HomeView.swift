//
//  HomeView.swift
//  ParkPalSwiftUI
//
//  Created by Mudit Arora on 4/21/23.
//

import Foundation
import SwiftUI
import CoreData
import CoreLocation
import MapKit

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showingAlert = false
    @State private var alert = false
    
    @ObservedObject var data: CoreController = CoreController()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \UserData.username, ascending: true)], animation: .default)
    private var items: FetchedResults<UserData>
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Home")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                
                TextField("username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                
                Button("Sign Up") {
                    data.saveInfo(username: username, password: password)
                    showingAlert = true
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                
                Spacer()
            }
            .background(Color.yellow.opacity(0.7))
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(destination: ContentView())  {
                        Image(systemName: "house.fill")
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                    }
                    Spacer()
                    NavigationLink(destination: FavoritesView()) {
                        Image(systemName: "heart.fill")
                    }
                }
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("User Added!"), message: Text("Hi, \(username)! Welcome to ParkPal"), dismissButton: .default(Text("OK")))
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
