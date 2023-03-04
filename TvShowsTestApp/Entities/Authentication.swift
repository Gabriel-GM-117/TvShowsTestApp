import Foundation

// MARK: - AuthResponse
struct AuthToken: Codable {
    let success: Bool?
    let requestToken, expiresAt: String?

    enum CodingKeys: String, CodingKey {
        case success
        case requestToken = "request_token"
        case expiresAt = "expires_at"
    }
}

// MARK: - AuthSessionResponse
struct AuthSessionResponse: Codable {
    let success: Bool?
    let sessionID: String?

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}

// MARK: - AuthUserResponse
struct AuthUserResponse: Codable {
    let success: Bool?
    let expiresAt, requestToken: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

// MARK: - RequestUser
struct RequestUser: Codable {
    let username: String?
    let password: String?
    let requestToken: String?

    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
}

// MARK: - LogOutResponse
struct LogOutResponse: Codable {
    let success: Bool?
}
