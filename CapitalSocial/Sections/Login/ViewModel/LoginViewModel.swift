//
//  LoginViewModel.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation


protocol LoginViewModelProtocol: class {
    
    var view: LoginViewControllerProtocol? { get set }
    
    func actionLogin(user: String, password: String)
}


class LoginViewModel: LoginViewModelProtocol {
    
    var view: LoginViewControllerProtocol?
    
    func actionLogin(user: String, password: String) {
        let dataLoginRequest = DataLoginRequest(pass: password, user: user)
        let loginRequest = LoginRequest(data: dataLoginRequest)
        view?.showLoading(message: CSString.Login.loading)
        CSAPI.shared.login(request: loginRequest, completion: { [weak self] (response) in
            guard let strongSelf = self, let token = response.token else { return }
            debugPrint(response)
            strongSelf.view?.hideLoading()
            //Save session
            UserDefaults.standard.set(token, forKey: AppDelegate.tokenkey)
            strongSelf.view?.presentPromotionsViewController()
        }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            strongSelf.view?.showMessage(message: error.description)
            debugPrint(error)
        }
    }
}
