import FluentSQLite
import Vapor

final class Rent: SQLiteModel {
    
    var id: Int?
    var userID: User.ID
    var bookID: Book.ID
    
    init(id: Int? = nil, userID: User.ID, bookID: Book.ID) {
        self.id = id
        self.userID = userID
        self.bookID = bookID
    }
}

extension Rent {
    
    var user: Parent<Rent, User> {
        return parent(\.userID)
    }
    
    var book: Parent<Rent, Book> {
        return parent(\.bookID)
    }
    
}

extension Rent: Content {}
extension Rent: Migration {}
extension Rent: Parameter {}
