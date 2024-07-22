

import Foundation

class UserDefaultMananger {
    static let shared = UserDefaultMananger()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func save<T: Encodable>(object: T, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            userDefaults.set(encoded, forKey: key)
        }
    }
    
    func get<T: Decodable>(key: String, type: T.Type) -> T? {
        if let data = userDefaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            }
        }
        return nil
    }
    
    func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func removeAll() {
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    func save<T: Encodable>(object: T, key: String, completion: @escaping (Bool) -> Void) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            userDefaults.set(encoded, forKey: key)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func get<T: Decodable>(key: String, type: T.Type, completion: @escaping (T?) -> Void) {
        if let data = userDefaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                completion(object)
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    
    func remove(key: String, completion: @escaping (Bool) -> Void) {
        userDefaults.removeObject(forKey: key)
        completion(true)
    }
    
    func removeAll(completion: @escaping (Bool) -> Void) {
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        completion(true)
    }
}
