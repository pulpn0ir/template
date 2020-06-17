import Vapor

struct AppUserController {
    func logIn(request: Request) -> EventLoopFuture<DataWrapper<AppUserLoginResponse>> {
        AppUserLoginRequest
            .logIn(
                on: request,
                errorOnWrongPassword: AppError.incorrectCredentials,
                currentDate: request.date.current()
            )
            .flatMapThrowing { try $0.map(AppUserMeResponse.init) }
            .map(DataWrapper.init)
    }

    func refreshToken(request: Request) throws -> DataWrapper<RefreshTokenResponse> {
        try .init(data: .init(AppUserRefreshKeychainConfig.makeToken(on: request)))
    }

    func create(request: Request) throws -> EventLoopFuture<Response> {
        AppUserCreateRequest
            .create(on: request)
            .flatMap(request.repositories.appUser.save)
            .flatMapThrowing(AppUserCreateResponse.init)
            .map(DataWrapper.init)
            .encodeResponse(status: .created, for: request)
    }

    func list(request: Request) throws -> EventLoopFuture<NodesPage<AppUserResponse>> {
        return request
            .repositories
            .appUser
            .all(searchterm: request.query.searchTerm, on: request)
            .flatMapThrowing { paginatedRespondents in
                try paginatedRespondents.map(AppUserResponse.init)
            }
            .map(NodesPage.init)
    }

    func single(request: Request) -> EventLoopFuture<DataWrapper<AppUserResponse>> {
        AppUser
            .find(on: request)
            .flatMapThrowing(AppUserCreateResponse.init)
            .map(DataWrapper.init)
    }

    func update(request: Request) throws -> EventLoopFuture<DataWrapper<AppUserUpdateResponse>> {
        AppUserUpdateRequest
            .update(on: request)
            .flatMap(request.repositories.appUser.save)
            .flatMapThrowing(AppUserUpdateResponse.init)
            .map(DataWrapper.init)
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        AppUser
            .find(on: request)
            .flatMap(request.repositories.appUser.delete)
            .transform(to: .noContent)
    }
}

extension AppUserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post("login", use: logIn)
        routes
            .grouped("me")
            .grouped(AppUserRefreshKeychainConfig.authenticator)
            .post("token", use: refreshToken)

        routes.get("", use: list)
        routes.post("", use: create)
        routes.get([.parameter(":userID")], use: single)
        routes.patch([.parameter(":userID")], use: update)
        routes.delete([.parameter(":userID")], use: delete)
    }
}
