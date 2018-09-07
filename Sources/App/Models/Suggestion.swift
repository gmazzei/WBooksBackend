import FluentSQLite
import Vapor

final class Suggestion: SQLiteModel {
    
    var id: Int?
    var title: String
    var author: String
    var link: String
    var userID: User.ID
    
    init(id: Int? = nil, title: String, author: String, link: String, userID: User.ID) {
        self.id = id
        self.title = title
        self.author = author
        self.link = link
        self.userID = userID
    }
}

extension Suggestion {
    
    var user: Parent<Suggestion, User> {
        return parent(\.userID)
    }
    
}

extension Suggestion: Content {}
extension Suggestion: Migration {}
extension Suggestion: Parameter {}
