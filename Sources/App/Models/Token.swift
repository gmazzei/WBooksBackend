import FluentSQLite
import Vapor
import Authentication

final class Token: SQLiteModel {
    var id: Int?
    var token: String
    var userID: User.ID
    
    init(token: String, userID: User.ID) {
        self.token = token
        self.userID = userID
    }
    
    static func createToken(forUser user: User) throws -> Token {
        let tokenString = TokenGenerator.createRandomToken(withLength: 60)
        let newToken = try Token(token: tokenString, userID: user.requireID())
        return newToken
    }
}

extension Token {
    var user: Parent<Token, User> {
        return parent(\.userID)
    }
}

extension Token: BearerAuthenticatable {
    static var tokenKey: WritableKeyPath<Token, String> { return \Token.token }
}

extension Token: Authentication.Token {
    static var userIDKey: WritableKeyPath<Token, User.ID> { return \Token.userID }
    typealias UserType = User
    typealias UserIDType = User.ID
}

extension Token: Content {}
extension Token: Migration {}
