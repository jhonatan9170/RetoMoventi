
import Foundation

class KeychainHelper {

    static let shared = KeychainHelper()

    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account] as CFDictionary

        SecItemDelete(query) // Elimina cualquier elemento existente
        let status = SecItemAdd(query, nil)
        guard status == errSecSuccess else { print("Error al guardar en Keychain"); return }
    }

    func load(service: String, account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        return status == errSecSuccess ? (result as? Data) : nil
    }

    func delete(service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account] as CFDictionary

        SecItemDelete(query)
    }
}
