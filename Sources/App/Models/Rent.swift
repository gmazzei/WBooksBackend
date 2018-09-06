import FluentSQLite
import Vapor

final class Rent: SQLiteModel {
    
    var id: Int?
    
    init(id: Int? = nil) {
        self.id = id
    }
}

extension Rent: Content {}
extension Rent: Migration {}
extension Rent: Parameter {}
