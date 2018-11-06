//
//  BaseProtocol.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/6/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import UIKit

protocol BaseProtocol : class {
    
    func showMessage(message: String)
    func showLoading(message: String)
    func hideLoading()
    
}

extension BaseProtocol where Self: UIViewController {
    func showMessage(message: String) {
        InformerView.shared.presentLoading(withText: message, delay: 2.0) {
            InformerView.shared.closeView()
        }
    }
    
    func showLoading(message: String) {
        InformerView.shared.presentLoading(withText: message)
    }
    
    func hideLoading() {
        InformerView.shared.closeView()
    }
    
}


extension BaseProtocol where Self: UICollectionViewController {
    func showMessage(message: String) {
        InformerView.shared.presentLoading(withText: message, delay: 2.0) {
            InformerView.shared.closeView()
        }
    }
    
    func showLoading(message: String) {
        InformerView.shared.presentLoading(withText: message)
    }
    
    func hideLoading() {
        InformerView.shared.closeView()
    }
    
}


