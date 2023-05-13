//
//  ContentView.swift
//  ParkPalSwiftUI
//
//  Created by Mudit Arora on 4/17/23.
//

import SwiftUI
import CoreData
import CoreLocation
import MapKit

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("🅿️ark🅿️al")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow.opacity(0.2))
                Spacer()
                
                NavigationLink(destination: HomeView()) {
                    Text("Sign Up")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                NavigationLink(destination: SearchView()) {
                    Text("Login As Guest")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                Spacer()
            }.background(Color.yellow.opacity(0.7))
        }.navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




