import AdminPanel
import Vapor

/// Register your application's routes here.
func routes(_ router: Router, _ container: Container) throws {

    // MARK: robots.txt

    if !container.environment.isRelease {
        router.get("robots.txt") { _ in
            return """
            User-agent: *
            Disallow: /"
            """
        }
    }

    // MARK: - Default routes
    try router.useHealthAPIRoutes(on: container)

    let sessionsRouter = router.grouped(SessionsMiddleware.self)
    try sessionsRouter.useAdminPanelRoutes(AdminPanelUser.self, on: container)
    try sessionsRouter.useNodesSSORoutes(AdminPanelUser.self, on: container)
    try sessionsRouter.useResetRoutes(AppUser.self, on: container)
    try sessionsRouter.useJWTKeychainRoutes(AppUser.self, on: container)

    // MARK: - Project specific routes
//    let adminPanel: AdminPanelMiddlewares = try container.make()
//    let jwtKeychain: JWTKeychainMiddlewares<AppUser> = try container.make()

    // MARK: API
//    let unprotectedApi = router
//    let protectedApi = unprotectedApi.grouped(jwtKeychain.accessMiddlewares)

    // MARK: Backend
//    let unprotectedBackend = router
//    let protectedBackend = unprotectedBackend.grouped(adminPanel.secure)
}
