//
//  APICenter.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/26.
//

import Foundation

// MARK: API KEY
let weatherAPIKey = ""

// MARK: HTTPMethod
// GET, PUT, POST, DELETE
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

// MARK: HTTPHeader
// field, value
struct HTTPHeader {
    let field: String
    let value: String
}

struct APICenter {
    typealias APIClientCompletion = (APIResult<Data?>) -> Void
    
    private let session = URLSession.shared
    
    func perform(urlString: String, request: APIRequest, completion: @escaping APIClientCompletion) {
        guard let baseURL = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var makeURLComponent = URLComponents()
        makeURLComponent.scheme = baseURL.scheme
        makeURLComponent.host = baseURL.host
        
        if let path = request.path {
            makeURLComponent.path = path
        }
        
        let queryItems = request.queryItems?.map({
            URLQueryItem(name: $0.key, value: "\($0.value)")
        })
        
        makeURLComponent.queryItems = queryItems
        
        guard let requestURL = makeURLComponent.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = session.dataTask(with: requestURL) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}
