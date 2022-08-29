//
//  NetworkEngine.swift
//  shoppy
//
//  Created by iQ on 8/12/22.
//

import Foundation

enum NetworkEngineError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
    case badRemoteUrl
    case decode
    case cacheImage
    case Unknown
}

protocol NetworkEngineProtocol {
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T , NetworkEngineError>) -> ())
}

class NetworkEngine: NetworkEngineProtocol {
 
    private var images = NSCache<NSString, NSData>()
    
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
    
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T , NetworkEngineError>) -> ()){
        
        let components = components(endpoint)
        guard let url = components.url else { return }
        let urlRequest = request(url: url, endpoint)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkEngineError.Unknown))
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkEngineError.badResponse(response)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkEngineError.badData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch let error{
                completion(.failure(NetworkEngineError.decode))
                print(error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
    
}
