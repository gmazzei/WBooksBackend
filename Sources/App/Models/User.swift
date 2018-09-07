import FluentSQLite
import Vapor
import Authentication

final class User: SQLiteModel {
    
    var id: Int?
    var username: String
    var password: String
        
    init(id: Int? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}

extension User {
    
    var comments: Children<User, Comment> {
        return children(\.userID)
    }
    
    var rents: Children<User, Rent> {
        return children(\.userID)
    }
    
    var wishes: Children<User, Wish> {
        return children(\.userID)
    }
    
    var suggestions: Children<User, Suggestion> {
        return children(\.userID)
    }
}

//Mark: - Authentication
extension User {
    struct PublicUser: Content {
        var username: String
        var token: String
    }
}

extension User: TokenAuthenticatable {
    typealias TokenType = Token
}

extension User: Content {}
extension User: Migration {}
extension User: Parameter {}
