import Vapor

final class WishController: BaseController {
    
    func list(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        return Wish
            .query(on: req)
            .join(\Book.id, to: \Wish.bookID)
            .join(\User.id, to: \Wish.userID)
            .alsoDecode(Book.self)
            .alsoDecode(User.self)
            .all()
            .map { tuples in
                
                let data = tuples.map { [unowned self] tuple in
                    self.createWish(wish: tuple.0.0, book: tuple.0.1, user: tuple.1)
                }
                
                return try self.createResponse(req, data: data)
        }
    }
    
    func create(_ req: Request) throws -> Future<Wish> {
        try checkAuth(req)
        return try req.content.decode(Wish.self).flatMap { wish in
            return wish.save(on: req)
        }
    }
    
    func show(_ req: Request) throws -> Future<Wish> {
        try checkAuth(req)
        return try req.parameters.next(Wish.self)
    }
}
