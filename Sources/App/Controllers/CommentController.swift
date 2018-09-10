import Vapor
import HTTP

final class CommentController: BaseController {
    
    func list(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        return Comment
            .query(on: req)
            .join(\Book.id, to: \Comment.bookID)
            .join(\User.id, to: \Comment.userID)
            .alsoDecode(Book.self)
            .alsoDecode(User.self)
            .all()
            .map { tuples in
                
                let data = tuples.map { [unowned self] tuple in
                    self.createComment(comment: tuple.0.0, book: tuple.0.1, user: tuple.1)
                }
                
                return try self.createResponse(req, data: data)
            }
    }
    
    
    func create(_ req: Request) throws -> Future<Comment> {
        try checkAuth(req)
        return try req.content.decode(Comment.self).flatMap { comment in
            return comment.save(on: req)
        }
    }
 
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        try checkAuth(req)
        return try req.parameters.next(Comment.self).flatMap { comment in
            return comment.delete(on: req)
        }.transform(to: .ok)
    }
    
    func show(_ req: Request) throws -> Future<Comment> {
        try checkAuth(req)
        return try req.parameters.next(Comment.self)
    }
}
