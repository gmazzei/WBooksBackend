import Vapor

final class UserController {

    func list(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    func update(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self).flatMap { user in
            return try req.content.decode(User.self).flatMap { newUser in
                user.username = newUser.username
                user.password = newUser.password
                return user.save(on: req)
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
            }.transform(to: .ok)
    }
    
    func show(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    func listComments(_ req: Request) throws -> Future<[Comment]> {
        return try req.parameters.next(User.self).flatMap { user in
            return try user.comments.query(on: req).all()
        }
    }
    
    func listRents(_ req: Request) throws -> Future<[Rent]> {
        return try req.parameters.next(User.self).flatMap { user in
            return try user.rents.query(on: req).all()
        }
    }
    
    func listWishes(_ req: Request) throws -> Future<[Wish]> {
        return try req.parameters.next(User.self).flatMap { user in
            return try user.wishes.query(on: req).all()
        }
    }
    
    func listSuggestions(_ req: Request) throws -> Future<[Suggestion]> {
        return try req.parameters.next(User.self).flatMap { user in
            return try user.suggestions.query(on: req).all()
        }
    }
}
