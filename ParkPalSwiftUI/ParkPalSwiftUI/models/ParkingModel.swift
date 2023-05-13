//
//  ParkingModel.swift
//  ParkPalSwiftUI
//
//  Created by Mudit Arora on 4/17/23.
//

import Foundation
import MapKit
// MARK: - ParkingModel
struct ParkingResult:Decodable {
    //let htmlAttributions: [Any?]
    //let nextPageToken: String
    let results: [Result]
    //let status: String
    
    /*enum CodingKeys: String, CodingKey {
     case htmlAttributions = "html_attributions"
     case nextPageToken = "next_page_token"
     case results, status
     }*/
}

struct Parking:Identifiable,Hashable,Equatable {
    let id:String
    let coordinate:CLLocationCoordinate2D
    let name:String
    let address:String
    let rating: Double
    
    static func == (lhs:Parking,rhs:Parking)->Bool{
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(coordinate.longitude)
        hasher.combine(coordinate.latitude)
    }
}

// MARK: - Result
struct Result: Decodable{
    //    let businessStatus: BusinessStatus
    let geometry: Geometry
    //    let icon: String
    //    let iconBackgroundColor: IconBackgroundColor
    //    let iconMaskBaseURI: String
    let name: String
    //    let openingHours: OpeningHours?
    //    let photos: [Photo]?
    let place_id: String
    //    let plusCode: PlusCode
    let rating: Double
    //    let reference: String
    //    let scope: Scope
    //    let types: [TypeElement]
    //    let userRatingsTotal: Int
    let vicinity: String
    
    //    enum CodingKeys: String, CodingKey {
    //        case businessStatus = "business_status"
    //        case geometry, icon
    //        case iconBackgroundColor = "icon_background_color"
    //        case iconMaskBaseURI = "icon_mask_base_uri"
    //        case name
    //        case openingHours = "opening_hours"
    //        case photos
    //        case placeID = "place_id"
    //        case plusCode = "plus_code"
    //        case rating, reference, scope, types
    //        case userRatingsTotal = "user_ratings_total"
    //        case vicinity
    //    }
}

enum BusinessStatus: String, Codable {
    case operational = "OPERATIONAL"
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
    let viewport: Viewport
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
}

// MARK: - Viewport
struct Viewport: Codable {
    let northeast, southwest: Location
}

enum IconBackgroundColor: String, Codable {
    case the7B9Eb0 = "#7B9EB0"
}

// MARK: - OpeningHours
struct OpeningHours: Codable {
    let openNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let height: Int
    let htmlAttributions: [String]
    let photoReference: String
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
        case width
    }
}

// MARK: - PlusCode
struct PlusCode: Codable {
    let compoundCode, globalCode: String
    
    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}

enum Scope: String, Codable {
    case google = "GOOGLE"
}

enum TypeElement: String, Codable {
    case establishment = "establishment"
    case parking = "parking"
    case pointOfInterest = "point_of_interest"
}

