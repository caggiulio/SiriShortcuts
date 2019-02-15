//
//  PaymentWallet.swift
//  App
//
//  Created by Nunzio Giulio Caggegi - Skylabs on 06/02/2019.
//

import Foundation
import FluentPostgreSQL
import Foundation
import Vapor

final class PaymentWallet: Content, Parameter {
    var id: Int?
    
    var amount: Double
    var consignee: String
    var timestamp: String?
    
    init(amount: Double, consignee: String, timestamp: String?) {
        self.amount = amount
        self.timestamp = timestamp
        self.consignee = consignee
    }
}

extension PaymentWallet: PostgreSQLModel {}
extension PaymentWallet: Migration {}
