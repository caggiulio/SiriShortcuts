//
//  PaymentController.swift
//  App
//
//  Created by Nunzio Giulio Caggegi - Skylabs on 06/02/2019.
//

import Foundation
import Vapor
import Fluent
import FluentPostgreSQL

final class PaymentController: RouteCollection {
    func boot(router: Router) throws {
        let payments = router.grouped("payments")
        
        payments.post(PaymentWallet.self, use: create)
        payments.get(use: index)
        payments.delete(LocationPark.parameter, use: delete)
        payments.get("total", use: totalAmount)
    }
    
    func create(_ request: Request, _ payment: PaymentWallet)throws -> Future<PaymentWallet> {
        if payment.timestamp == nil {
            payment.timestamp = Date().description.stringToDate()
        }
        return payment.save(on: request)
    }
    
    func index(_ request: Request)throws -> Future<[PaymentWallet]> {
        if let dateReq = try? request.query.get(String.self, at: "date") {
            //timestamp >= dateReq -> se ci sono timestamp che contengono quella data
            return PaymentWallet.query(on: request).filter(\.timestamp >= dateReq).all()
        } else {
            return PaymentWallet.query(on: request).all()
        }
    }
    
    func delete(_ request: Request)throws -> Future<HTTPStatus> {
        return try request.parameters.next(PaymentWallet.self).delete(on: request).transform(to: .noContent)
    }
    
    func totalAmount(_ request: Request)throws -> Future<Double> {
        if let dateReq = try? request.query.get(String.self, at: "date") {
            return PaymentWallet.query(on: request).filter(\.timestamp >= dateReq).sum(\.amount, default: 0)
        } else {
            return PaymentWallet.query(on: request).sum(\.amount, default: 0)
        }
    }
    
    /*func test(_ request: Request)throws -> Future<PaymentWallet> {
        return PaymentWallet.query(on: request).first().unwrap(or: Abort.init(HTTPResponseStatus.init(statusCode: 401)))
    }*/
}

struct PaymentWalletContent: Content {
    var amount: Double?
    var consignee: String?
    var timestamp: String?
}
