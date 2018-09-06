import FluentSQLite
import Vapor

final class Wish: SQLiteModel {
    
    var id: Int?
    
    init(id: Int? = nil) {
        self.id = id
    }
}

extension Wish: Content {}
extension Wish: Migration {}
extension Wish: Parameter {}
