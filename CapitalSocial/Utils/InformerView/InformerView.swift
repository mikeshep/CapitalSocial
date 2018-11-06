//
//  InformerView.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//   Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import UIKit


import UIKit
typealias Done = (String?) -> ()

class InformerView {
    private var instance: GenericMaskView!
    private var oldStatusBarStyle: UIStatusBarStyle = .default
    //MARK:- Singleton
    static let shared = InformerView()
    private init() {
        instance = GenericMaskView(frame: UIScreen.main.bounds)
    }
    
    
    
    //MARK:- Methods

    
    ///Shows a Loading view
    ///
    /// - Parameters:
    ///     - text: The text to show
    ///     - delay: Optional delay before to perform the completion block. The default value is zero
    ///     - completion: Optional block to perform once the Loading view is displayed
    func presentLoading(withText text: String, delay: Double = 0.0, andCompletion completion: @escaping (() -> ()) = {}) {
        addViewToWindow()
        
        instance.loadingView.alpha = 0
        LoaderCircleAnimation.setUpAnimation(in: instance.loadingView.layer,
                                             location: .zero,
                                             size: instance.loadingView.frame.size,
                                             color: CSColor.primaryColor)
        instance.loadingView.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.instance.viewBlack.alpha = 1
        })
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [.curveEaseIn], animations: {
            self.instance.loadingView.alpha = 1
            self.instance.titleLabel.text = text
            self.instance.loadingView.layoutIfNeeded()
        }, completion: {(finished) in
            self.instance.viewType = .loading
            self.instance.loadingView.isHidden = false
            if delay <= 0.0 {
                DispatchQueue.main.async { completion() }
            } else {
                let when = DispatchTime.now() + delay
                DispatchQueue.main.asyncAfter(deadline: when, execute: completion)
            }
        })
    }

    
    
    func closeView(withCompletion completion: @escaping (() -> ()) = {}) {
        //UIApplication.shared.statusBarStyle = oldStatusBarStyle
        instance.closeView(withCompletion: completion)
    }
    
    private func addViewToWindow() {
        //oldStatusBarStyle = UIApplication.shared.statusBarStyle
        //UIApplication.shared.statusBarStyle = .lightContent
        if !instance.isViewAdded {
            let window = UIApplication.shared.delegate!.window!
            window?.addSubview(instance)
        }
    }
    
    
}
