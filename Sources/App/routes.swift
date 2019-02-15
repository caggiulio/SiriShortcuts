import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    try router.register(collection: LocationParkController())
    try router.register(collection: PaymentController())
}
