//
//  SearchView.swift
//  ParkPalSwiftUI
//
//  Created by Mudit Arora on 4/21/23.
//

import Foundation
import SwiftUI
import CoreData
import CoreLocation
import MapKit

struct SearchView: View {
    @State private var cityName = ""
    @State private var longitude = ""
    @State private var latitude = ""
    @State private var results: [Parking] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                        .frame(width: 10)
                    TextField("Enter a city name", text: $cityName)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button(action: {
                        getParkingSpots()
                    }) {
                        Image(systemName: "magnifyingglass")
                    }.padding(.trailing, 10)
                }.padding(.vertical, 10)
                
                Spacer()
                List {
                    ForEach(results, id: \.id) { spot in
                        NavigationLink(destination: DetailView(name: spot.name, address: spot.address, rate: spot.rating)) {
                            VStack(alignment: .leading) {
                                Text("\(spot.name)")
                                Text("\(spot.address)")
                            }
                            .padding(10)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                }
            }
            .background(Color.yellow.opacity(0.8))
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
        }.navigationBarBackButtonHidden(true)
    }
    
    
    func getParkingSpots() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let error = error {
                print("Geocode error: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                if let coordinate = placemark.location?.coordinate {
                    let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=1000&keyword=parking&key=APIKEY"
                    
                    guard let url = URL(string: urlString) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else if let data = data {
                            do {
                                let response = try JSONDecoder().decode(ParkingResult.self, from: data)
                                results = response.results.map{
                                    result in Parking(id: result.place_id, coordinate: CLLocationCoordinate2D(latitude: result.geometry.location.lat, longitude: result.geometry.location.lng), name: result.name, address: result.vicinity, rating: result.rating)
                                }
                            } catch {
                                print("Error decoding JSON: \(error.localizedDescription)")
                            }
                        }
                    }.resume()
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
