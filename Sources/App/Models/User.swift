import FluentSQLite
import Vapor

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

extension User: Content {}
extension User: Migration {}
extension User: Parameter {}
