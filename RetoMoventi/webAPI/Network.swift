//
//  Network.swift
//  RetoMoventi
//
//  Created by Jhonatan Chavez  on 21/07/24.
//

import RxSwift

class Network {
    
    static func request<T: Decodable>(url: URL, method: String, parameters: [String: Any]? = nil) -> Observable<T> {
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = method
            
            if let parameters = parameters {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "Network", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"]))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(T.self, from: data)
                    observer.onNext(object)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
