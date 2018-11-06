//
//  CSAPI+Login.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation
import Alamofire

//MARK: - API Helpers. Result enumeration
/**
 Custom response for service closures
 
 - success: Success service call
 - failure: Fail service call with error description
 */
enum Result {
    case success(Any)
    case failure(CSError)
}

typealias Response = (Result) -> Void

//MARK: - Requestable protocol extension
///Protocol for generic services objects
protocol Requestable {
    /**
     Return a NSError from custom Data in body response
     
     - parameter from: Data from body response
     - returns: A custom NSError from body response
     */
    func error(from data: Data) -> CSError
}

//MARK: - Requestable protocol extension
///Protocol extension with custom perform method definition
extension Requestable {
    /**
     Generic Alamofire request call for all Requestable objects
     
     - parameter request: URLRequestConvertible from the endpoint to call
     - parameter completion: Closure with `Result` value from the request, this closure is obtained from original call
     */
    func perform(request: URLRequestConvertible, logResponse: Bool = true, completion: @escaping Response) {
        let request = Alamofire.request(request).validate()
        
        request.responseJSON { response in
            guard let rsp = response.response else {
                completion(.failure(CSError.generic))
                return
            }
            
            // log response
            if let value = response.result.value, logResponse {
                print();print()
                print("== SERVER RESPONSE ==")
                print(request.request!.url!); print("statusCode \(rsp.statusCode)")
                print(value)
                print();print();
            }
            
            if rsp.statusCode >= 200 && rsp.statusCode <= 299 && response.data?.count == 0 {
                completion(.success(true))
                return
            } else if rsp.statusCode >= 400 && rsp.statusCode <= 499 {
                if let messageData = response.data {
                    let error = self.error(from: messageData)
                    completion(.failure(error))
                } else {
                    completion(.failure(CSError.badRequest))
                }
                return
            }
            
            guard response.result.isSuccess else {
                if let error = response.result.error {
                    debugPrint("    Error: \(error.localizedDescription)")
                }
                if let messageData = response.data {
                    completion(.failure(self.error(from: messageData)))
                } else {
                    completion(.failure(CSError.generic))
                }
                return
            }
            
            if response.data?.count == 0 {
                completion(.success(true))
            } else if let data = response.data {
                completion(.success(data))
            } else {
                completion(.failure(CSError.invalidJSON))
            }
        }
    }
}


//MARK: - Capital Social API
///A singleton for every service call in the application
class CSAPI: Requestable {
    static let shared = CSAPI()
    private init() {
        listenForReachability()
    }
    
    private func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    var isReachability: Bool  {
        return _isReachability
    }
    
    private var _isReachability: Bool = false
    
    private func listenForReachability() {
        self.reachabilityManager?.listener = { status in
            print("Network Status Changed: \(status)")
            switch status {
            case .notReachable:
            //Show error state
                self._isReachability = false
            case .reachable, .unknown:
                //Hide error state
                self._isReachability = true
            }
        }
        
        self.reachabilityManager?.startListening()
    }
    
    // MARK: Requestable method
    /**
     Transforms a Data object obtained in an error request y the correct error for the failure 'Result'
     
     - parameter from: Data with the binary JSON bad response from the service
     */
    func error(from data: Data) -> CSError {
        debugPrint("**** \(String(data: data, encoding: String.Encoding.utf8) ?? "")")
        do {
            guard let JSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return CSError.generic
            }
            
            debugPrint("========= errorJSON =========");debugPrint(JSON);debugPrint("=========")
            
            var code: Int? = nil
            
            if let errCode = JSON["code"] as? NSNumber {
                code = errCode.intValue
            } else if let errCode = JSON["code"] as? String {
                code = Int(errCode)
            }
            
            guard let errorCode = code, let error = ErrorCode(rawValue: errorCode) else {
                return CSError.invalidJSON
            }
            
            switch error {
           //put here error codes for BrainChain app
            case .invalidJSON:
                return CSError.invalidJSON
            default:
                if errorCode == NSURLErrorTimedOut {
                    return CSError.timeout
                } else if errorCode >= 500 && errorCode <= 599 {
                    return CSError.serviceError
                } else if errorCode >= 400 && errorCode <= 499{
                    return CSError.badRequest
                } else {
                    return CSError.generic
                }
            }
        }
        catch {
            return CSError.generic
        }
    }
    
    //MARK:- private Keys
    private struct Keys {
        static let token = "token"
    }
}
