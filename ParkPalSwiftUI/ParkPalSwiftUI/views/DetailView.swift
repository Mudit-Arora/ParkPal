//
//  DetailView.swift
//  ParkPalSwiftUI
//
//  Created by Mudit Arora on 4/21/23.
//

import Foundation
import SwiftUI
import CoreData
import CoreLocation
import MapKit

struct DetailView: View {
    let name: String
    let address: String
    let rate: Double
    @State private var showingAlert = false
    
    @State private var results: [Parking] = []
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var data: CoreController = CoreController()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ParkingData.name, ascending: true)], animation: .default)
    private var items: FetchedResults<ParkingData>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text(name)
                        .font(.title)
                    Text(address)
                        .multilineTextAlignment(.center)
                    Text("Rating: \(rate)")
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Button(action: {
                    openMaps(Address: address)
                }) {
                    Text("Get Directions")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                Button(action: {
                    showingAlert = true
                    data.saveData(name: name, address: address)
                }) {
                    Text("Add to Favorites")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .background(Color.orange.opacity(0.6))
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
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Added to Favorites!"), message: Text("\(name) added to favorites"), dismissButton: .default(Text("OK")))
            }
        }
    }
        
        func openMaps(Address: String) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(Address) { placemarks, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    print("No placemarks found for the address: \(Address)")
                    return
                }
                
                let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                mapItem.name = name
                mapItem.openInMaps(launchOptions: nil)
            }
        }
    }

