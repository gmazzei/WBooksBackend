import Vapor
import FluentPostgreSQL
import Authentication

class BaseController {
    
    internal func checkAuth(_ req: Request) throws {
        try req.requireAuthenticated(User.self)
    }
    
    internal func createGetResponse(_ req: Request, data: Any) throws -> Response {
        let response = req.makeResponse()
        response.http.status = .ok
        response.http.headers.replaceOrAdd(name: .contentType, value: "application/json")
        
        let json = try JSONSerialization.data(withJSONObject: data)
        response.http.body = HTTPBody(data: json)
        
        return response
    }
    
    internal func createPostResponse(_ req: Request, data: Data) -> Response {
        let response = req.makeResponse()
        response.http.status = .created
        response.http.headers.replaceOrAdd(name: .contentType, value: "application/json")
        response.http.body = HTTPBody(data: data)
        return response
    }
    
    internal func createComment(comment: Comment, book: Book, user: User) -> [String:Any] {
        var comment = comment.toDictionary()
        comment["book"] = book.toDictionary()
        comment["user"] = user.toDictionary()
        return comment
    }
    
    internal func createWish(wish: Wish, book: Book, user: User) -> [String:Any] {
        var wish = wish.toDictionary()
        wish["book"] = book.toDictionary()
        wish["user"] = user.toDictionary()
        return wish
    }
    
    internal func createRent(rent: Rent, book: Book, user: User) -> [String:Any] {
        var rent = rent.toDictionary()
        rent["book"] = book.toDictionary()
        rent["user"] = user.toDictionary()
        return rent
    }
    
    internal func createSuggestion(suggestion: Suggestion, user: User) -> [String:Any] {
        var suggestion = suggestion.toDictionary()
        suggestion["user"] = user.toDictionary()
        return suggestion
    }
    
}
