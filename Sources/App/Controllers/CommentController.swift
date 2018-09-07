import Vapor

final class CommentController {
    
    func list(_ req: Request) throws -> Future<[Comment]> {
        return Comment.query(on: req).all()
    }
    
    
    func create(_ req: Request) throws -> Future<Comment> {
        return try req.content.decode(Comment.self).flatMap { comment in
            return comment.save(on: req)
        }
    }
 
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Comment.self).flatMap { comment in
            return comment.delete(on: req)
        }.transform(to: .ok)
    }
    
    func show(_ req: Request) throws -> Future<Comment> {
        return try req.parameters.next(Comment.self)
    }
}
