import Vapor
import FluentSQLite

final class SuggestionController: BaseController {
    
    func list(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        return Suggestion
            .query(on: req)
            .join(\User.id, to: \Suggestion.userID)
            .alsoDecode(User.self)
            .all()
            .map { tuples in
                
                let data = tuples.map { [unowned self] tuple in
                    self.createSuggestion(suggestion: tuple.0, user: tuple.1)
                }
                
                return try self.createResponse(req, data: data)
        }
    }
    
    
    func show(_ req: Request) throws -> Future<Response> {
        try checkAuth(req)
        let suggestionId = try req.parameters.next(Int.self)
        
        let future = Suggestion.query(on: req)
            .filter(\Suggestion.id == suggestionId)
            .join(\User.id, to: \Suggestion.userID)
            .alsoDecode(User.self)
            .first()
        
        return future.map { [unowned self] tuple in
            let data = self.createSuggestion(suggestion: tuple!.0, user: tuple!.1)
            return try self.createResponse(req, data: data)
        }
    }
    
    func create(_ req: Request) throws -> Future<Suggestion> {
        try checkAuth(req)
        return try req.content.decode(Suggestion.self).flatMap { suggestion in
            return suggestion.save(on: req)
        }
    }
}
