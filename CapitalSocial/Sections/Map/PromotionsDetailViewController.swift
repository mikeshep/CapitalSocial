//
//  PromotionsDetailViewController.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/6/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import UIKit

class PromotionsDetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtvDescription: UITextView!
    
    var data:Promotion?
    var promoImage:UIImage?
    
    var promoTitle:String?
    var promoImageName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation
        self.navigationItem.title = CSString.appTitle
    
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action:#selector(share))
        self.navigationItem.rightBarButtonItem = button
        
        //title and image
        promoTitle = data?.title ?? "Lorem ipsum"
        promoImageName = data?.image ?? "placeHolder"
        promoImage = UIImage(named: promoImageName!)
        
        self.lblTitle.text = promoTitle
        self.image.image = promoImage
        
    }
    
    //Share in social media
    @objc func share(){
        if let promoImage = promoImage {
            let vc = UIActivityViewController(activityItems: [promoTitle!, promoImage], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
