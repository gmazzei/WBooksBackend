import Vapor

public func routes(_ router: Router) throws {
    
    let tokenAuthenticationMiddleware = User.tokenAuthMiddleware()
    let authedRoutes = router.grouped(tokenAuthenticationMiddleware)
    
    let authController = AuthenticationController()
    router.post("auth", use: authController.createAuthenticationToken)
    
    
    let userController = UserController()
    authedRoutes.get("users", use: userController.list)
    authedRoutes.get("users", User.parameter, use: userController.show)
    authedRoutes.post("users", use: userController.create)
    authedRoutes.get("users", User.parameter, "rents", use: userController.listRents)
    authedRoutes.get("users", User.parameter, "rents", Rent.parameter, use: userController.showRent)
    authedRoutes.post("users", User.parameter, "rents", use: userController.createRent)
    authedRoutes.get("users", User.parameter, "wishes", use: userController.listWishes)
    authedRoutes.get("users", User.parameter, "wishes", Wish.parameter, use: userController.showWish)
    authedRoutes.get("users", User.parameter, "comments", use: userController.listComments)
    
    
    let bookController = BookController()
    authedRoutes.get("books", use: bookController.list)
    authedRoutes.get("books", Book.parameter, use: bookController.show)
    authedRoutes.post("books", use: bookController.create)
    authedRoutes.get("books", Book.parameter, "rents", use: bookController.listRents)
    authedRoutes.get("books", Book.parameter, "rents", use: bookController.showRent)
    authedRoutes.get("books", Book.parameter, "comments", Comment.parameter, use: bookController.showComment)
    authedRoutes.get("books", Book.parameter, "comments", use: bookController.listComments)
    authedRoutes.post("books", Book.parameter, "comments", use: bookController.createComment)
    
    
    let suggestionController = SuggestionController()
    authedRoutes.get("suggestions", use: suggestionController.list)
    authedRoutes.get("suggestions", Suggestion.parameter, use: suggestionController.show)
    authedRoutes.post("suggestions", use: suggestionController.create)
 
}
