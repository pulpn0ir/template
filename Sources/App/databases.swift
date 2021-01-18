import Fluent{{db.module}}Driver
import Vapor

func databases(_ app: Application) throws {
    // let's see
    try app.databases.use(.postgres(url: Environment.postgreSQLURL), as: .psql)
}
