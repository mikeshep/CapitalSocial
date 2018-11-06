//
//  Login.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/6/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation


struct LoginResponse: Codable {
    var agente: String?
    var error: LoginResponseError?
    var id_user: Int?
    var token: String?
}

struct LoginResponseError: Codable {
    var id: String
    var message: String
    var title: String
}

struct LoginRequest: Codable {
    var data: DataLoginRequest
}

struct DataLoginRequest: Codable {
    var pass: String
    var user: String
}


typealias LoginCompletion = (LoginResponse) -> ()
