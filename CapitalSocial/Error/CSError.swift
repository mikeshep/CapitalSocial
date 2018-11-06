//
//  CSError.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation


//MARK:- Error Codes
enum ErrorCode: Int {
    case generic = 1
    case badRequest
    case serviceError
    case timeout
    case invalidJSON
    case notInternetConnection
    
}

//MARK:- Error Keys
enum ErrorKey: String {
    case generic = "Hubo un error\nPor favor\nIntentalo de nuevo"
    case badRequest = "Alguno de los datos es incorrecto.\n Por favor verifca la información y vuelve a intentarlo"
    case serviceError = "Error en el servicio"
    case timeout = "El servicio esta tardando en responder"
    case invalidJSON = "No es posible leer la respuesta del servicio"
    case notInternetConnection = "No tienes conexión a internet, intentalo más tarde"
}


//MARK:- CSError Definition
let CSServicesDomain = "com.brainchain.errors.service"
class CSError: NSError {
    var localizedTitle = ""
    
    override var description: String {
        return self.localizedDescription
    }
    
    fileprivate convenience init(localizedTitle: String? = nil,
                                 localizedDescription: ErrorKey,
                                 code: ErrorCode) {
        
        self.init(domain: CSServicesDomain, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey: localizedDescription.rawValue])
        self.localizedTitle = localizedTitle ?? "Error"
    }
    
    convenience init(rawDesc: String, rawCode: Int) {
        self.init(domain: CSServicesDomain, code: rawCode, userInfo: [NSLocalizedDescriptionKey: rawDesc])
        self.localizedTitle = "Error"
    }
    
    // Error génerico :v
    static let generic = CSError(localizedDescription: ErrorKey.generic, code: ErrorCode.generic)
    /// Alguno de los datos es incorrecto. Por favor verifca la información y vuelve a intentarlo
    static let badRequest = CSError(localizedDescription: ErrorKey.badRequest, code: ErrorCode.badRequest)
    /// Error en el servicio
    static let serviceError = CSError(localizedDescription: ErrorKey.serviceError, code: ErrorCode.serviceError)
    /// El servicio esta tardando en responder
    static let timeout = CSError(localizedDescription: ErrorKey.timeout, code: ErrorCode.timeout)
    /// No es posible leer la respuesta del servicio
    static let invalidJSON = CSError(localizedDescription: ErrorKey.invalidJSON, code: ErrorCode.invalidJSON)
    /// Sin conexión a internet
    static let notInternetConnection = CSError(localizedDescription: ErrorKey.notInternetConnection, code: ErrorCode.notInternetConnection)
}

