import Vapor

final class SuggestionController {
    
    func list(_ req: Request) throws -> Future<[Suggestion]> {
        return Suggestion.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<Suggestion> {
        return try req.content.decode(Suggestion.self).flatMap { suggestion in
            return suggestion.save(on: req)
        }
    }
    
    func show(_ req: Request) throws -> Future<Suggestion> {
        return try req.parameters.next(Suggestion.self)
    }
}
