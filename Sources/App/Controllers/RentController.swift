import Vapor

final class RentController: BaseController {
    
    func list(_ req: Request) throws -> Future<[Rent]> {
        try checkAuth(req)
        return Rent.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<Rent> {
        try checkAuth(req)
        return try req.content.decode(Rent.self).flatMap { rent in
            return rent.save(on: req)
        }
    }
    
    func show(_ req: Request) throws -> Future<Rent> {
        try checkAuth(req)
        return try req.parameters.next(Rent.self)
    }
}
