import Vapor

final class BookController {
    
    func list(_ req: Request) throws -> Future<[Book]> {
        return Book.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<Book> {
        return try req.content.decode(Book.self).flatMap { book in
            return book.save(on: req)
        }
    }
    
    func update(_ req: Request) throws -> Future<Book> {
        return try req.parameters.next(Book.self).flatMap { book in
            return try req.content.decode(Book.self).flatMap { newBook in
                book.author = newBook.author
                book.title = newBook.title
                book.image = newBook.image
                book.year = newBook.year
                book.genre = newBook.genre
                return book.save(on: req)
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Book.self).flatMap { book in
            return book.delete(on: req)
            }.transform(to: .ok)
    }
}
