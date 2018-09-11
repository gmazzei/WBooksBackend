import Vapor
import FluentSQLite
import Authentication

/// Called before your application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    //let myService = NIOServerConfig.default(port: 8080)
    //services.register(myService)

    try services.register(FluentSQLiteProvider())

    var databases = DatabasesConfig()
    try databases.add(database: SQLiteDatabase(storage: .memory), as: .sqlite)
    services.register(databases)
    
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .sqlite)
    migrations.add(model: Book.self, database: .sqlite)
    migrations.add(model: Comment.self, database: .sqlite)
    migrations.add(model: Rent.self, database: .sqlite)
    migrations.add(model: Wish.self, database: .sqlite)
    migrations.add(model: Suggestion.self, database: .sqlite)
    migrations.add(model: Token.self, database: .sqlite)
    services.register(migrations)
    
    try services.register(AuthenticationProvider())
}
