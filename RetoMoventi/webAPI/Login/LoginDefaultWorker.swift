import RxSwift
import MoventiCore

class LoginDefaultWorker: LoginWorker {
    
    func login(_ input: LoginInput) -> Observable<Void> {
        
        let url = URL(string: Constants.urlLogin)!
        let device = UIDevice.current
        let deviceID = device.identifierForVendor?.uuidString ?? ""
        let deviceName = device.name
        let deviceVersion = device.systemVersion
        let deviceWidth = "\(UIScreen.main.bounds.width)"
        let deviceHeight = "\(UIScreen.main.bounds.height)"
        let deviceModel = device.model
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let deviceInfo = Device(deviceID: deviceID, name: deviceName, version: deviceVersion, width: deviceWidth, heigth: deviceHeight, model: deviceModel, platform: "ios")
        
        let requestBody = LoginRequest(user: UserLogin(usrCode: input.email, pass: input.password, profile: ProfileLogin(language: "es")), device: deviceInfo, app: App(version: appVersion))
        
        let headers = ["Authorization" : Constants.tokenauthsession]
        
        return Network.shared.request(url: url, method: "POST", requestBody: requestBody,headers: headers)
            .map { (response: LoginResponse) in
                let data = response.data
                SessionManager.shared.saveToken(data.accessToken)
                SessionManager.shared.saveRefreshToken(data.refreshToken)
                SessionManager.shared.start()
                return ()
            }
        
    }
}

// MARK: - Welcome
struct LoginRequest: Codable {
    let user: UserLogin
    let device: Device
    let app: App
}

// MARK: - App
struct App: Codable {
    let version: String
}

// MARK: - Device
struct Device: Codable {
    let deviceID, name, version, width: String
    let heigth, model, platform: String

    enum CodingKeys: String, CodingKey {
        case deviceID = "deviceId"
        case name, version, width, heigth, model, platform
    }
}

// MARK: - User
struct UserLogin: Codable {
    let usrCode, pass: String
    let profile: ProfileLogin

    enum CodingKeys: String, CodingKey {
        case usrCode = "usr_code"
        case pass, profile
    }
}
struct ProfileLogin: Codable {
    let language: String
}

struct LoginResponse: Codable {
    let data: LoginResponseData
}

// MARK: - DataClass
struct LoginResponseData: Codable {
    let accessToken, refreshToken: String
    let expiresIn: String
    let tokenType: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: String
    let rbac: Rbac?
    let profile: Profile

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rbac, profile
    }
}

// MARK: - Profile
struct Profile: Codable {
    let language, userName, languages: String?
}

// MARK: - CountriesLogin
struct CountriesLogin: Codable {
    let code: String
}

// MARK: - Rbac
struct Rbac: Codable {
    let role, template: String?
}

