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
    
    func update(_ req: Request) throws -> Future<Suggestion> {
        return try req.parameters.next(Suggestion.self).flatMap { suggestion in
            return try req.content.decode(Suggestion.self).flatMap { newSuggestion in
                suggestion.title = newSuggestion.title
                suggestion.author = newSuggestion.author
                suggestion.link = newSuggestion.link
                return suggestion.save(on: req)
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Suggestion.self).flatMap { suggestion in
            return suggestion.delete(on: req)
            }.transform(to: .ok)
    }
    
    func show(_ req: Request) throws -> Future<Suggestion> {
        return try req.parameters.next(Suggestion.self)
    }
}
