import Vapor

final class UserController: BaseController {
    
    func list(_ req: Request) throws -> Future<[User]> {
        try checkAuth(req)
        return User.query(on: req).all()
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
    
    func listComments(_ req: Request) throws -> Future<[Comment]> {
        try checkAuth(req)
        return try req.parameters.next(User.self).flatMap { user in
            return try user.comments.query(on: req).all()
        }
    }
    
    func listRents(_ req: Request) throws -> Future<[Rent]> {
        try checkAuth(req)
        return try req.parameters.next(User.self).flatMap { user in
            return try user.rents.query(on: req).all()
        }
    }
    
    func listWishes(_ req: Request) throws -> Future<[Wish]> {
        try checkAuth(req)
        return try req.parameters.next(User.self).flatMap { user in
            return try user.wishes.query(on: req).all()
        }
    }
    
    func listSuggestions(_ req: Request) throws -> Future<[Suggestion]> {
        try checkAuth(req)
        return try req.parameters.next(User.self).flatMap { user in
            return try user.suggestions.query(on: req).all()
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
}
