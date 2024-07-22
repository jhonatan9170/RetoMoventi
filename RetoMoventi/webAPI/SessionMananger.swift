
import Foundation
import UIKit

class SessionManager {
    static let shared = SessionManager()
    private var startDate: Date?
    private var timer: Timer!
    private var hasloggedIn = false
    private let tokenKey = "sessionToken"
    private let refreshToken = "refreshToken"

    private let tokenService = "com.moventi.tokenservice"

    func saveToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        KeychainHelper.shared.save(data, service: tokenService, account: tokenKey)
    }
    func saveRefreshToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        KeychainHelper.shared.save(data, service: tokenService, account: tokenKey)
    }
    
    func getToken() -> String? {
        guard let tokenData = KeychainHelper.shared.load(service: tokenService, account: tokenKey),
              let token = String(data: tokenData, encoding: .utf8) else {
            KeychainHelper.shared.delete(service: tokenService, account: tokenKey)
            return nil
        }
        return token
    }
    
    func start() {
        hasloggedIn = true
        startDate = Date()
        timer?.invalidate()
        runTimer()
    }
    private func runTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(validateTimer),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }
    
    @objc private func validateTimer() {
        let time = getTime()
        if time >= Constants.foregroundSessionMaxTime,hasloggedIn {
            timer.invalidate()
            
        }
    }
    
    private func showSessionExpiredAlert() {
        // Show alert
        let rootViewController = getRootViewController()
        let alert = UIAlertController(title: "Session expired", message: "Your session has expired", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self]_ in
            self?.hasloggedIn = false
            rootViewController?.popToRootViewController(animated: true)
        }))
        rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func getRootViewController() -> UINavigationController? {
        return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
    }
    
     private func getTime() -> Int {
        if let startDate = startDate {
            let timeElapsed = -Int(startDate.timeIntervalSinceNow)
            return timeElapsed
        }
        return 0
    }

}
