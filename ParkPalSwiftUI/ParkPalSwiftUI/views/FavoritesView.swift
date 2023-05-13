//
//  FavoritesView.swift
//  ParkPalSwiftUI
//
//  Created by Mudit Arora on 4/21/23.
//

import Foundation
import SwiftUI
import CoreData
import CoreLocation
import MapKit


struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var data: CoreController = CoreController()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ParkingData.name, ascending: true)], animation: .default)
    private var items: FetchedResults<ParkingData>
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Favorites")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange.opacity(0.5))
                
                List {
                    ForEach(data.parkingData) { item in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(item.name!)")
                                .font(.headline)
                            Text("\(item.address!)")
                                .font(.subheadline)
                        }
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let parkingToDelete = data.parkingData[index].name
                            data.deleteData(name: parkingToDelete ?? "")
                        }
                    })
                }
                .background(Color.orange)
                .navigationBarHidden(true)
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
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
