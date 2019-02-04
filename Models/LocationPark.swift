//
//  LocationPark.swift
//  App
//
//  Created by Nunzio Giulio Caggegi - Skylabs on 04/02/2019.
//

import Foundation
import FluentPostgreSQL
import Foundation
import Vapor

final class LocationPark: Content, Parameter {
    var id: Int?
    
    var lat: Double
    var lng: Double
    var timestamp: String?
    var street: String
    
    init(lat: Double, lng: Double, street: String) {
        self.lat = lat
        self.lng = lng
        self.timestamp = Date().description
        self.street = street
    }
}

extension LocationPark: PostgreSQLModel {}
extension LocationPark: Migration {}
