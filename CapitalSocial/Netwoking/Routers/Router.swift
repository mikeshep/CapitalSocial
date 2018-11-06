//
//  CSAPI+Login.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Alamofire

protocol Router {
    associatedtype R: Codable
    var baseURL: String { get }
    var endPoint: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var body: R? { get }
    var headers: HTTPHeaders? { get }
    var authField: String? { get }
}

protocol Routable: Router, URLRequestConvertible {
    
    
}

extension Routable{
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var authField: String? {
        return nil
    }
    
    var body: R? {
        return nil
    }
    
    var baseURL: String {
        return "https://agentemovil.pagatodo.com/AgenteMovil.svc"
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        url.appendPathComponent(endPoint)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let hFields = headers {
            for (header, value) in hFields {
                urlRequest.setValue(value, forHTTPHeaderField: header)
            }
        }
        
        if let auth = authField {
            urlRequest.setValue(auth, forHTTPHeaderField: "Authorization")
        }
        
        switch method {
        case .post, .put, .patch, .delete:
            if let bodyObject = try? JSONEncoder().encode(body) {
                urlRequest.httpBody = bodyObject
                
                if let str = String(data: bodyObject, encoding: String.Encoding.utf8) as String? {
                    debugPrint("param: \(str)")
                }
            }
        default:
            var urlComp = URLComponents(string: url.absoluteString)!
            var items = [URLQueryItem]()
            
            if let bodyObject = try? JSONEncoder().encode(body), let params  = try? JSONSerialization.jsonObject(with: bodyObject, options: []) as? [String: String] {
                for (key,value) in params! {
                    items.append(URLQueryItem(name: key, value: value))
                }
            }
            items = items.filter{!$0.name.isEmpty}
            urlComp.queryItems = items
            urlRequest.url = urlComp.url
        }
        return urlRequest
    }
}
