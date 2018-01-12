//
//  CureViewController.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import SafariServices

class CureViewController: UIViewController {
    
    var goodCurefood: [Food]?
    var dataSource = CollectionViewDataSource(items: [])
    var diseaseUrl: String?
    var diseaseImg: CustomImageView!
    
    @IBOutlet weak var diseaseImgView: CustomImageView!
    @IBOutlet weak var cureFoodCollectionView: UICollectionView!
    
    func setDiseaseImg() {
        diseaseImgView.loadImageFromUrlString(urlString: self.diseaseUrl!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        cureFoodCollectionView.dataSource = self.dataSource
        dataSource.items = goodCurefood!
        cureFoodCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        diseaseImgView.image = diseaseImg.image
        cureFoodCollectionView.delegate = self
        let cell = UINib(nibName: "CureFoodCell", bundle: Bundle.main)
        cureFoodCollectionView.register(cell, forCellWithReuseIdentifier: "cureFoodCell")
        dataSource.configureCell = {(cureFoodCollectionView, indexPath) -> UICollectionViewCell in
            let cell = cureFoodCollectionView.dequeueReusableCell(withReuseIdentifier: "cureFoodCell", for: indexPath) as! CureFoodCell
            guard let curefood = self.goodCurefood else { return UICollectionViewCell()}
            cell.delegate = self
            cell.foodCureLabel.text = curefood[indexPath.row].name
            cell.foodCureImg.loadImageFromUrlString(urlString: curefood[indexPath.row].image_url)
            return cell
        }
    }
}
extension CureViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing = layout.minimumInteritemSpacing
        let insets = layout.sectionInset.left + layout.sectionInset.right
        let width = (collectionView.bounds.size.width * 0.5) - (insets + itemSpacing)
        let height = collectionView.bounds.size.height * 0.3
        
        return CGSize(width: width, height: height)
    }
}

extension CureViewController: PassBuy {
    func actionSent(_ sender: CureFoodCell) {
        let amazonUrl = URL(string: "https://www.amazon.com")
        let vc = SFSafariViewController(url: amazonUrl!, entersReaderIfAvailable: true)
        self.present(vc, animated: true)
    }
}
