import Vapor
import Authentication

final class AuthenticationController {
    
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
    
}
