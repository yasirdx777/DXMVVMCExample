//
//  NetworkEngine.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/12/22.
//

import Foundation
import RxSwift


protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}

enum NetworkEngineError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
    case badRemoteUrl
    case decode
    case cacheImage
    case Unknown
}

// sourcery: AutoMockable
protocol NetworkEngineProtocol {
    func request<T: Codable>(type: T.Type, endpoint: Endpoint) -> Single<T>
}

class NetworkEngine: NetworkEngineProtocol {
    
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    private func components(_ endpoint: Endpoint) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    private func request(url: URL, _ endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = endpoint.method
        return request
    }
    
    func request<T: Codable>(type: T.Type, endpoint: Endpoint) -> Single<T> {
        return Single<T>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            let components = self.components(endpoint)
            guard let url = components.url else { return Disposables.create() }
            let urlRequest = self.request(url: url, endpoint)
            
            let dataTask = self.session.dataTask(with: urlRequest) { data, response, error in
                
                if let error = error {
                    single(.failure(NetworkEngineError.Unknown))
                    print(error.localizedDescription)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    single(.failure(NetworkEngineError.badResponse(response)))
                    return
                }
                
                guard let data = data else {
                    single(.failure(NetworkEngineError.badData))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    single(.success(response))
                } catch let error{
                    single(.failure(NetworkEngineError.decode))
                    print(error.localizedDescription)
                }
            }
            
            dataTask.resume()
           
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
}

