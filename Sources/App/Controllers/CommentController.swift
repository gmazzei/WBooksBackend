import Vapor

final class CommentController: BaseController {
    
    func list(_ req: Request) throws -> Future<[Comment]> {
        try checkAuth(req)
        return Comment.query(on: req).all()
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
