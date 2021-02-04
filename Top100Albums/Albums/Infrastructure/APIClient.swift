//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

//enum ServiceMethod: String {
//    case get = "GET"
//    // implement more when needed: post, put, delete, patch, etc.
//}
//
//protocol Service {
//    var baseURL: String { get }
//    var path: String { get }
//    var parameters: [String: Any]? { get }
//    var method: ServiceMethod { get }
//}
//
//extension Service {
//    public var urlRequest: URLRequest? {
//        guard let url = self.url else {
//            return nil
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//
//        return request
//    }
//
//    private var url: URL? {
//        var urlComponents = URLComponents(string: baseURL)
//        urlComponents?.path = path
//
//        if method == .get {
//            guard let parameters = parameters as? [String: String] else {
//                return nil
//            }
//            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
//        }
//
//        return urlComponents?.url
//    }
//}
//
//enum Result<T> {
//    case success(T)
//    case failure(Error)
//    case empty
//}
//
//class ServiceProvider<T: Service> {
//    var urlSession = URLSession.shared
//
//    init() { }
//
//    func load(service: T, completion: @escaping (Result<Data>) -> Void) {
//        call(service.urlRequest, completion: completion)
//    }
//
//    func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U>) -> Void) where U: Decodable {
//        call(service.urlRequest) { result in
//            switch result {
//            case .success(let data):
//                let decoder = JSONDecoder()
//                do {
//                    let resp = try decoder.decode(decodeType, from: data)
//                    completion(.success(resp))
//                }
//                catch {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            case .empty:
//                completion(.empty)
//            }
//        }
//    }
//}
//
//extension ServiceProvider {
//    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data>) -> Void) {
//        urlSession.dataTask(with: request) { (data, _, error) in
//            if let error = error {
//                deliverQueue.async {
//                    completion(.failure(error))
//                }
//            } else if let data = data {
//                deliverQueue.async {
//                    completion(.success(data))
//                }
//            } else {
//                deliverQueue.async {
//                    completion(.empty)
//                }
//            }
//        }.resume()
//    }
//}
//
//enum AlbumsService {
//    case getAlbums()
//}
//
//extension AlbumsService: Service {
//    var baseURL: String {
//        return "https://rss.itunes.apple.com/api"
//    }
//
//    var path: String {
//        switch self {
//        case .getAlbums():
//            return "/v1/us/apple-music/top-albums/all/100/explicit.json"
//    }
//
//    var parameters: [String: Any]? {
//        return [:]
//    }
//
//    var method: ServiceMethod {
//        return .get
//    }
//}