import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let userController = UserController()
    router.get("users", use: userController.list)
    router.get("users", User.parameter, use: userController.show)
    router.get("users", User.parameter, "rents", Rent.parameter, use: userController.showRent)
    router.get("users", User.parameter, "comments", use: userController.listComments)
    router.get("users", User.parameter, "rents", use: userController.listRents)
    router.get("users", User.parameter, "wishes", use: userController.listWishes)
    router.get("users", User.parameter, "suggestions", use: userController.listSuggestions)
    router.post("users", use: userController.create)
    router.post("users", User.parameter, "rents", use: userController.createRent)
    
    let bookController = BookController()
    router.get("books", use: bookController.list)
    router.get("books", Book.parameter, use: bookController.show)
    router.get("books", Book.parameter, "comment", Comment.parameter, use: bookController.showComment)
    router.get("books", Book.parameter, "comments", use: bookController.listComments)
    router.get("books", Book.parameter, "rents", use: bookController.listRents)
    router.get("books", Book.parameter, "wishes", use: bookController.listWishes)
    router.post("books", use: bookController.create)
    router.post("books", Book.parameter, "comments", use: bookController.createComment)
    
    let commentController = CommentController()
    router.get("comments", use: commentController.list)
    router.get("comments", Comment.parameter, use: commentController.show)
    router.post("comments", use: commentController.create)
    
    let rentController = RentController()
    router.get("rents", use: rentController.list)
    router.get("rents", Rent.parameter, use: rentController.show)
    router.post("rents", use: rentController.create)
    
    let wishController = WishController()
    router.get("wishes", use: wishController.list)
    router.get("wishes", Wish.parameter, use: wishController.show)
    router.post("wishes", use: wishController.create)
    
    let suggestionController = SuggestionController()
    router.get("suggestions", use: suggestionController.list)
    router.get("suggestions", Suggestion.parameter, use: suggestionController.show)
    router.post("suggestions", use: suggestionController.create)
}
