internal enum EnvironmentKey {
    enum Project {
        static let name = "PROJECT_NAME"
        static let url  = "PROJECT_URL"
    }

    enum MySQL {
        static let hostname = "DATABASE_HOSTNAME"
        static let username = "DATABASE_USER"
        static let password = "DATABASE_PASSWORD"
        static let database = "DATABASE_DB"
    }

    enum Redis {
        static let hostname = "REDIS_HOSTNAME"
        static let database = "REDIS_DATABASE"
    }

    enum Mailgun {
        static let apiKey = "MAILGUN_PASSWORD"
        static let domain = "MAILGUN_DOMAIN"
    }

    enum JWTKeychain {
        static let accessTokenSignerKey  = "JWT_ACCESS_SIGNER_KEY"
        static let refreshTokenSignerKey = "JWT_REFRESH_SIGNER_KEY"
    }

    enum AdminPanel {
        static let setPasswordSignerKey = "ADMIN_PANEL_SET_PASSWORD_SIGNER_KEY"
    }

    enum Reset {
        static let signerKey = "RESET_SIGNER_KEY"
        static let setPasswordSignerKey = "RESET_SET_PASSWORD_SIGNER_KEY"
    }

    enum NodesSSO {
        static let url         = "PROJECT_URL"
        static let redirectURL = "NODES_SSO_REDIRECT_URL"
        static let salt        = "NODES_SSO_SALT"
    }

    enum Bugsnag {
        static let key = "BUGSNAG_API_KEY"
    }
}
