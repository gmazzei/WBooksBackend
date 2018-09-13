import Vapor
import FluentPostgreSQL
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

    try services.register(FluentPostgreSQLProvider())
    let databaseUrl = ProcessInfo.processInfo.environment["DATABASE_URL"]
    print("DATABASE URL = \(databaseUrl)")
    /*
    let postgresqlConfig = PostgreSQLDatabaseConfig(
        hostname: "127.0.0.1",
        port: 5432,
        username: "gabrielleandromazzei",
        database: "wbooks",
        password: nil
    )
    */
    /*
    let postgresqlConfig = PostgreSQLDatabaseConfig(
        hostname: "ec2-75-101-153-56.compute-1.amazonaws.com",
        port: 5432,
        username: "shkiiqdbrpuwci",
        database: "d7p1hi5krji6i8",
        password: "28bf3122ca40d885c6bcfaee5b8f6a6af58f59b8ba1d3515d06f68b4afb2aff2"
    )
    */
    
    let postgresqlConfig = PostgreSQLDatabaseConfig(url: databaseUrl!)!
    services.register(postgresqlConfig)
    
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    migrations.add(model: Book.self, database: .psql)
    migrations.add(model: Comment.self, database: .psql)
    migrations.add(model: Rent.self, database: .psql)
    migrations.add(model: Wish.self, database: .psql)
    migrations.add(model: Suggestion.self, database: .psql)
    migrations.add(model: Token.self, database: .psql)
    services.register(migrations)
    
    try services.register(AuthenticationProvider())
}
