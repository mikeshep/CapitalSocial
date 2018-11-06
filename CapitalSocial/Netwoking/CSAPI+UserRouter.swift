//
//  CSAPI+Login.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation

extension CSAPI {
    
    func login(request: LoginRequest, completion: @escaping LoginCompletion, error: ((CSError) -> ())? ) {
//        if !isReachability {
//            error?(BCError.notInternetConnection)
//        }
        perform(request: UserRouter.login(request)) { (result) in
            switch result {
            case .success(let data):
                do {
                    if let JSON = data as? Data{
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: JSON)
                        guard let e = loginResponse.error  else {
                            completion(loginResponse)
                            return
                        }
                        let csError = CSError(rawDesc: e.message, rawCode: Int(e.id) ?? 0)
                        error?(csError)
                    }else{
                        error?(CSError.invalidJSON)
                    }
                }catch let e {
                    debugPrint(e)
                    error?(CSError.invalidJSON)
                }
                break
            case .failure(let e):
                error?(e)
                break
            }
        }
    }
    
}


