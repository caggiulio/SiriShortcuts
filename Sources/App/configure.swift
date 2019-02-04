import FluentPostgreSQL
import Vapor

public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
    ) throws {
    try services.register(FluentPostgreSQLProvider())
    
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    /*services.register { _ in
        NIOServerConfig.init(hostname: "0.0.0.0", port: 8082, backlog: 256, workerCount: ProcessInfo.processInfo.activeProcessorCount, maxBodySize: 1_000_000, reuseAddress: true, tcpNoDelay: true)
    }*/
    
    var databases = DatabasesConfig()
    //let config = PostgreSQLDatabaseConfig(hostname: "localhost", username: "giulio-skylabs", database: "parks")
    let config = PostgreSQLDatabaseConfig(hostname: "localhost", username: "giulio", database: "parks", password: "cgg41355756nzg")
    databases.add(database: PostgreSQLDatabase(config: config), as: .psql)
    services.register(databases)
    
    var commands = CommandConfig.default()
    commands.useFluentCommands()
    services.register(commands)
    
    var migrations = MigrationConfig()
    migrations.add(model: LocationPark.self, database: .psql)
    services.register(migrations)
}
