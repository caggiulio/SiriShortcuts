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

final class Location: Content {
    var id: Int?
    
    var lat: Double
    var lng: Double
    var date: String
    var street: String
    
    init(lat: Double, lng: Double, date: String, street: String) {
        self.lat = lat
        self.lng = lng
        self.date = date
        self.street = street
    }
}

extension Location: PostgreSQLModel {}
extension Location: Migration {}
