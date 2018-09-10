import Vapor

final class RentController: BaseController {
    
    func list(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        return Rent
            .query(on: req)
            .join(\Book.id, to: \Rent.bookID)
            .join(\User.id, to: \Rent.userID)
            .alsoDecode(Book.self)
            .alsoDecode(User.self)
            .all()
            .map { tuples in
                
                let data = tuples.map { [unowned self] tuple in
                    self.createRent(rent: tuple.0.0, book: tuple.0.1, user: tuple.1)
                }
                
                return try self.createResponse(req, data: data)
        }
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
