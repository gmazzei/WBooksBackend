import Vapor

final class SuggestionController: BaseController {
    
    func list(_ req: Request) throws -> Future<[Suggestion]> {
        try checkAuth(req)
        return Suggestion.query(on: req).all()
    }
    
    func show(_ req: Request) throws -> Future<Suggestion> {
        try checkAuth(req)
        return try req.parameters.next(Suggestion.self)
    }
    
    func create(_ req: Request) throws -> Future<Suggestion> {
        try checkAuth(req)
        return try req.content.decode(Suggestion.self).flatMap { suggestion in
            return suggestion.save(on: req)
        }
    }
}
