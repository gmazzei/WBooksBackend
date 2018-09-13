import Vapor
import Authentication
import FluentPostgreSQL

final class AuthenticationController {
    
    /*
    func createAuthenticationToken(_ request: Request) throws -> Future<User.PublicUser> {
        return try request.content.decode(User.self)
            .flatMap(to: User.PublicUser.self) { user in
            
            let passwordHashed = try request.make(BCryptDigest.self).hash(user.password)
            let newUser = User(username: user.username, password: passwordHashed)
            
            return newUser.save(on: request).flatMap(to: User.PublicUser.self) { createdUser in
                let accessToken = try Token.createToken(forUser: createdUser)
                return accessToken.save(on: request).map(to: User.PublicUser.self) { createdToken in
                    let publicUser = User.PublicUser(username: createdUser.username, token: createdToken.token)
                    return publicUser
                }
            }
            
        }
    }
    */
    
    func createAuthenticationToken(_ request: Request) throws -> Future<User.PublicUser> {
        var plainTextPassword: String? = .none
        
        return try request.content.decode(User.self)
            .flatMap(to: User.self) { user in
                plainTextPassword = user.password
                
                return User.query(on: request)
                    .filter(\User.username == user.username)
                    .first()
                    .unwrap(or: Abort(.notFound)) // TODO: Change for appropiate error
    
            }.flatMap(to: User.PublicUser.self) { user in
                let passwordMatches = try BCrypt.verify(plainTextPassword!, created: user.password)
                
                if passwordMatches {
                    let accessToken = try Token.createToken(forUser: user)
                    return accessToken.save(on: request).map(to: User.PublicUser.self) { createdToken in
                        let publicUser = User.PublicUser(username: user.username, token: createdToken.token)
                        return publicUser
                    }
                } else {
                    throw WrongPasswordError()
                }
        }
    
    }
}

class WrongPasswordError: AbortError {
    var status: HTTPResponseStatus
    var reason: String
    var identifier: String
    
    init() {
        self.status = HTTPResponseStatus.unauthorized
        self.reason = "Username and password are not valid credentials"
        self.identifier = ""
    }
}
