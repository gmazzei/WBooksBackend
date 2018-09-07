import Vapor

final class BookController: BaseController {
    
    func list(_ req: Request) throws -> Future<[Book]> {
        try checkAuth(req)
        return Book.query(on: req).all()
    }
    
    func show(_ req: Request) throws -> Future<Book> {
        try checkAuth(req)
        return try req.parameters.next(Book.self)
    }
    
    func showComment(_ req: Request) throws -> Future<Comment> {
        try checkAuth(req)
        return try req.parameters.next(Book.self).flatMap { book in
            return try req.parameters.next(Comment.self)
        }
    }
    
    func listComments(_ req: Request) throws -> Future<[Comment]> {
        try checkAuth(req)
        return try req.parameters.next(Book.self).flatMap { book in
            return try book.comments.query(on: req).all()
        }
    }
    
    func listRents(_ req: Request) throws -> Future<[Rent]> {
        try checkAuth(req)
        return try req.parameters.next(Book.self).flatMap { book in
            return try book.rents.query(on: req).all()
        }
    }
    
    func listWishes(_ req: Request) throws -> Future<[Wish]> {
        try checkAuth(req)
        return try req.parameters.next(Book.self).flatMap { book in
            return try book.wishes.query(on: req).all()
        }
    }
    
    func create(_ req: Request) throws -> Future<Book> {
        try checkAuth(req)
        return try req.content.decode(Book.self).flatMap { book in
            return book.save(on: req)
        }
    }
    
    func createComment(_ req: Request) throws -> Future<Comment> {
        try checkAuth(req)
        return try req.content.decode(Comment.self).flatMap { comment in
            return comment.save(on: req)
        }
    }
    
}
