import FluentSQLite
import Vapor

final class Suggestion: SQLiteModel {
    
    var id: Int?
    var title: String
    var author: String
    var link: String
    
    init(id: Int? = nil, title: String, author: String, link: String) {
        self.id = id
        self.title = title
        self.author = author
        self.link = link
    }
}

extension Suggestion: Content {}
extension Suggestion: Migration {}
extension Suggestion: Parameter {}
