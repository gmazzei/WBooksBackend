import Vapor

final class UserController: BaseController {
    
    func list(_ req: Request) throws -> Future<[User]> {
        try checkAuth(req)
        return User.query(on: req).all()
    }
    
    func listComments(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        
        let future = try req.parameters.next(User.self).flatMap { user in
            return try user.comments
                .query(on: req)
                .join(\Book.id, to: \Comment.bookID)
                .join(\User.id, to: \Comment.userID)
                .alsoDecode(Book.self)
                .alsoDecode(User.self)
                .all()
        }
        
        return future.map { tuples in
            
            let data = tuples.map { [unowned self] tuple in
                self.createComment(comment: tuple.0.0, book: tuple.0.1, user: tuple.1)
            }
            
            return try self.createResponse(req, data: data)
        }
        
    }
    
    func listRents(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        let future = try req.parameters.next(User.self).flatMap { user in
            return try user.rents
                .query(on: req)
                .join(\Book.id, to: \Rent.bookID)
                .join(\User.id, to: \Rent.userID)
                .alsoDecode(Book.self)
                .alsoDecode(User.self)
                .all()
        }
        
        return future.map { tuples in
                
                let data = tuples.map { [unowned self] tuple in
                    self.createRent(rent: tuple.0.0, book: tuple.0.1, user: tuple.1)
                }
                
                return try self.createResponse(req, data: data)
        }
    }
    
    func listWishes(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        let future = try req.parameters.next(User.self).flatMap { user in
            return try user.wishes
                .query(on: req)
                .join(\Book.id, to: \Wish.bookID)
                .join(\User.id, to: \Wish.userID)
                .alsoDecode(Book.self)
                .alsoDecode(User.self)
                .all()
        }
        
        return future.map { tuples in
                
                let data = tuples.map { [unowned self] tuple in
                    self.createWish(wish: tuple.0.0, book: tuple.0.1, user: tuple.1)
                }
                
                return try self.createResponse(req, data: data)
        }
    }
    
    func show(_ req: Request) throws -> Future<User> {
        try checkAuth(req)
        return try req.parameters.next(User.self)
    }
    
    
    func showRent(_ req: Request) throws -> Future<Rent> {
        try checkAuth(req)
        return try req.parameters.next(User.self).flatMap { user in
            return try req.parameters.next(Rent.self)
        }
    }
    
    func showWish(_ req: Request) throws -> Future<Wish> {
        try checkAuth(req)
        return try req.parameters.next(User.self).flatMap { user in
            return try req.parameters.next(Wish.self)
        }
    }
    
    func create(_ req: Request) throws -> Future<User> {
        try checkAuth(req)
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    func createRent(_ req: Request) throws -> Future<Rent> {
        try checkAuth(req)
        return try req.content.decode(Rent.self).flatMap { rent in
            return rent.save(on: req)
        }
    }
    
    func createWish(_ req: Request) throws -> Future<Wish> {
        try checkAuth(req)
        return try req.content.decode(Wish.self).flatMap { wish in
            return wish.save(on: req)
        }
    }
}
