import Vapor

final class WishController: BaseController {
    
    func list(_ req: Request) throws -> Future<[Wish]> {
        try checkAuth(req)
        return Wish.query(on: req).all()
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
