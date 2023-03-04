import Foundation

enum Repository {
    static var tokenAuth: AuthToken?
    static var userPass: String?
    static var userName: String?
    static var authSession: AuthSessionResponse?
    static var authSessionFlag: Bool = false
}
