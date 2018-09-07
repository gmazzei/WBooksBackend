import Authentication

class BaseController {
    
    internal func checkAuth(_ req: Request) throws {
        try req.requireAuthenticated(User.self)
    }
    
}
