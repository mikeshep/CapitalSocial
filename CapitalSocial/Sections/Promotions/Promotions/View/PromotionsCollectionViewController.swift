//
//  PromotionsCollectionViewController.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/6/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PromotionsCollectionViewCell"

protocol PromotionsCollectionViewControllerProtocol: BaseProtocol {

    var viewModel: PromotionViewModelProtocol? { get set }
    
    func setNeedsUpdateCollectionView()
    
    func presentDetail(promotion: Promotion)
    
}

class PromotionsCollectionViewController: UICollectionViewController, PromotionsCollectionViewControllerProtocol {
    var viewModel: PromotionViewModelProtocol? = PromotionViewModel()
    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel!.view = self
        
        viewModel!.actionPopulate()
        
        //navigation configuration
        self.navigationItem.title = CSString.appTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        

        // Register cell classes
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: PromotionsCollectionViewControllerProtocol
    func setNeedsUpdateCollectionView() {
        collectionView.reloadData()
    }
    
    func presentDetail(promotion: Promotion) {
        let viewController: PromotionsDetailViewController = UIStoryboard.storyboard(storyboard: .main).instantiateViewController()
        viewController.data = promotion
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
   
}

 // MARK: UICollectionViewDelegate
extension PromotionsCollectionViewController  {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let promotion = viewModel!.promotions[indexPath.row]
        viewModel!.didSelect(promotion: promotion)
    }
}

// MARK: UICollectionViewDataSource
extension PromotionsCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel!.promotions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PromotionsCollectionViewCell
        // Configure the cell
        let promotion = viewModel!.promotions[indexPath.row]
        cell.lbTitle.text = promotion.title
        cell.imvCover.image = UIImage(named: promotion.image)
        return cell
    }

}

// MARK: Padding space, Margins and arrange of cells
extension PromotionsCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
