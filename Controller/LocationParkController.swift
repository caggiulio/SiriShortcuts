//
//  LocationParkController.swift
//  App
//
//  Created by Nunzio Giulio Caggegi - Skylabs on 04/02/2019.
//

import Foundation
import Vapor
import Fluent
import FluentPostgreSQL

final class LocationParkController: RouteCollection {
    func boot(router: Router) throws {
        let locationParks = router.grouped("locationParks")
        
        locationParks.post(LocationPark.self, use: create)
        locationParks.get(use: index)
    }
    
    func create(_ request: Request, _ locationPark: LocationPark)throws -> Future<LocationPark> {
        locationPark.timestamp = Date().description.stringToDate()
        return locationPark.save(on: request)
    }
    
    func index(_ request: Request)throws -> Future<[LocationPark]> {
        if let dateReq = try? request.query.get(String.self, at: "date") {
            //timestamp >= dateReq -> se ci sono timestamp che contengono quella data
            return LocationPark.query(on: request).filter(\.timestamp >= dateReq).all()
        } else {
            return LocationPark.query(on: request).all()
        }
    }
}

struct LocationParkContent: Content {
    var lat: Double?
    var lng: Double?
    var timestamp: String?
    var street: String?
}
