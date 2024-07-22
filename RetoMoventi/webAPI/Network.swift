

import RxSwift

class Network {
    
     static let shared = Network()
    
     func request<T: Decodable>(url: URL, method: String, requestBody: Codable? = nil,headers: [String: String]? = nil) -> Observable<T> {
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = method
            if let requestBody = requestBody, let parameters = requestBody.toDictionary(){
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                print(String(data: request.httpBody!, encoding: .utf8) ?? "")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            if let headers = headers {
                headers.forEach { key, value in
                    request.addValue(value, forHTTPHeaderField: key)
                }
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
                print(String(data: data, encoding: .utf8) ?? "")

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
