//
//  CSAPI+Login.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Alamofire

enum UserRouter<T: Codable>: Routable {
    typealias E = T
    
    case login(T)
    
    var endPoint: String {
        switch self {
        case .login:
            return "/agMov/login"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var headers: HTTPHeaders? {
        return ["Accept-Language": "es",
                "Content-Type": "application/json",
                "Time-Zone": "America/Mexico_City"]
    }
    
    var body: T? {
        switch self {
        case .login(let data):
            return data
        }
    }
}
