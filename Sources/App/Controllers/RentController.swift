import Vapor

final class RentController {
    
    func list(_ req: Request) throws -> Future<[Rent]> {
        return Rent.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<Rent> {
        return try req.content.decode(Rent.self).flatMap { rent in
            return rent.save(on: req)
        }
    }
    
    func show(_ req: Request) throws -> Future<Rent> {
        return try req.parameters.next(Rent.self)
    }
}
