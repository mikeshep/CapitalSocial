//
//  GenericMask.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//   Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import UIKit


struct AlertViewListItem {
    let name: String
    var isAvailable: Bool = true
}


class GenericMaskView: UIView {
    static let nibName = "GenericMaskView"
    private var view: UIView!
    var viewType = MaskViewType.undefined
    var isViewAdded: Bool {
        return self.superview == nil ? false: true
    }
    
    //Loading view
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var viewBlack: UIView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //InputTextView
    var minimumCharactersInputTextView: Int?
    
    //MARK:- Required initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK:- Configuration methods
    ///Configures the view according to the viewType
    private func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        
        viewBlack.alpha = 0
        
        loadingView.isHidden = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        // Assumes UIView is top level and only object in CustomPopUp file
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: GenericMaskView.nibName, bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomPopUp file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    
    func closeView(withCompletion completion: @escaping (() -> ()) = {}) {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.loadingView.alpha = 0
        })
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [.curveEaseIn], animations: {
            self.viewBlack.alpha = 0
        }, completion: {(finished) in
            self.removeFromSuperview()
            completion()
        })
    }
}

//MARK:- Convenience enum
///Identifies a GenericMaskView as a specific type of view
enum MaskViewType {
    case loading, undefined
}


extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
