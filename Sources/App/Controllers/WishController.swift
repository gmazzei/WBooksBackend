import Vapor

final class WishController {
    
    func list(_ req: Request) throws -> Future<[Wish]> {
        return Wish.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<Wish> {
        return try req.content.decode(Wish.self).flatMap { wish in
            return wish.save(on: req)
        }
    }
    
    func update(_ req: Request) throws -> Future<Wish> {
        return try req.parameters.next(Wish.self).flatMap { wish in
            return try req.content.decode(Wish.self).flatMap { newWish in
                return wish.save(on: req)
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Wish.self).flatMap { wish in
            return wish.delete(on: req)
            }.transform(to: .ok)
    }
    
    func show(_ req: Request) throws -> Future<Wish> {
        return try req.parameters.next(Wish.self)
    }
}
