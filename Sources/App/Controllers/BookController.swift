import Vapor
import FluentSQLite

final class BookController: BaseController {
    
    func list(_ req: Request) throws -> Future<[Book]> {
        try checkAuth(req)
        return Book.query(on: req).all()
    }
    
    func listComments(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        
        let future = try req.parameters.next(Book.self).flatMap { book in
            return try book.comments
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
            
            return try self.createGetResponse(req, data: data)
        }
        
    }
    
    
    func listRents(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        let future = try req.parameters.next(Book.self).flatMap { book in
            return try book.rents
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
            
            return try self.createGetResponse(req, data: data)
        }
    }
    
    func show(_ req: Request) throws -> Future<Book> {
        try checkAuth(req)
        return try req.parameters.next(Book.self)
    }
    
    func showComment(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        let book = try req.parameters.next(Book.self)
        let commentId = try req.parameters.next(Int.self)
        
        let future = Comment.query(on: req)
            .filter(\Comment.id == commentId)
            .join(\Book.id, to: \Comment.bookID)
            .join(\User.id, to: \Comment.userID)
            .alsoDecode(Book.self)
            .alsoDecode(User.self)
            .first()
        
        return future.map { [unowned self] tuple in
            let data = self.createComment(comment: tuple!.0.0, book: tuple!.0.1, user: tuple!.1)
            return try self.createGetResponse(req, data: data)
        }
    }
    
    func showRent(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        let bookId = try req.parameters.next(Int.self)
        let rentId = try req.parameters.next(Int.self)
        
        let future = Rent.query(on: req)
            .filter(\Rent.bookID == bookId)
            .filter(\Rent.id == rentId)
            .join(\Book.id, to: \Rent.bookID)
            .join(\User.id, to: \Rent.userID)
            .alsoDecode(Book.self)
            .alsoDecode(User.self)
            .first()
        
        return future.map { [unowned self] tuple in
            let data = self.createRent(rent: tuple!.0.0, book: tuple!.0.1, user: tuple!.1)
            return try self.createGetResponse(req, data: data)
        }
    }
    
    func create(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        let future = try req.content.decode(Book.self).flatMap { book in
            return book.save(on: req)
        }
        
        return future.map { [unowned self] book in
            let data = try JSONEncoder().encode(book)
            return self.createPostResponse(req, data: data)
        }
    }
    
    func createComment(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        let future = try req.content.decode(Comment.self).flatMap { comment in
            return comment.save(on: req)
        }
        
        return future.map { [unowned self] comment in
            let data = try JSONEncoder().encode(comment)
            return self.createPostResponse(req, data: data)
        }
    }
    
}
