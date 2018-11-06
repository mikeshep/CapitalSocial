//
//  CSString.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation


struct CSString {
    ///Brain Chain App
    static let appTitle = "Capital Social"

    
    ///Aceptar
    static let ok = "Ok"
    static let cancel = "Cancel"
    
    static let magnitude = "Magnitude"
    
    static let searchRequestTitle = "Search"
    
    static let emptyLabels = "You have some empty fields necessary for the query."
    static let locationServiceDisabled = "Location services disabled, please enable them in phone settings."
    static let withoutSaveData = "Without stored data."
    
    
    struct Login {
        static let qrScanCodeButton = "Escanea código QR"
        static let emailPasswordInput = "o ingresa tu correo y contraseña"
        static let user = "Usuario"
        static let password = "Contraseña"
        static let signIn = "Ingresar"
        static let signUp = "Registrate"
        static let passwordForgot = "¿Has olvidado tu contraseña?"
        static let loading = "Cargando..."
        static let withoutPasswordOrUser = "Ingresa tu usario y contraseña."
        static let withoutPermissions = "This app is not authorized to use Back Camera."
        static let notSupported = "Reader not supported by the current device"
    }
    
    struct ContactList {
        static let searchBarTitle = "Search Contacts"
        static let contactDelete = "Do you want to delete this contact?"
        static let deleting = "Deleting..."
    }
    
    struct Map {
        static let titleMap = "Mapa"
    }
    
    
}
