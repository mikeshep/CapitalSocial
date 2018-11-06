//
//  PromotionsViewModel.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/6/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation

protocol PromotionViewModelProtocol: class {
    
    var view: PromotionsCollectionViewControllerProtocol? { get set }
    
    func actionPopulate()
    
    var promotions:[Promotion] { get }
    
    func didSelect(promotion: Promotion)
    
}

class PromotionViewModel: PromotionViewModelProtocol {
    var view: PromotionsCollectionViewControllerProtocol?
    
    fileprivate let data = ["Benavides",
                              "Burguer King",
                              "Chilis",
                              "Cinepolis",
                              "Italiannis",
                              "Idea Interior",
                              "Pizza",
                              "Tizoncito",
                              "Wingstop",
                              "Zona Fitness",
                              "Otro"]
    
    fileprivate let images = ["PromoBenavides",
                            "PromoBurguerKing",
                            "PromoChilis",
                            "PromoCinepolis",
                            "PromoItaliannis",
                            "PromoIdeaInterior",
                            "PromoPizza",
                            "PromoTizoncito",
                            "PromoWingstop",
                            "PromoZonaFitness",
                            ""]
    
    
    var promotions:[Promotion] = []
    
    func actionPopulate() {
        for (name, image) in zip(data, images) {
            let p = Promotion(title: name, image: image == "" ? "placeholder": image)
            promotions.append(p)
            view?.setNeedsUpdateCollectionView()
        }
    }
    
    func didSelect(promotion: Promotion) {
        view?.presentDetail(promotion: promotion)
    }
    
}
