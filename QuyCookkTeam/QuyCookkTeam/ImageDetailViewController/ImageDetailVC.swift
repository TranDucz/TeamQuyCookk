//
//  ImageDetailVC.swift
//  QuyCookkTeam
//
//  Created by Hartzed Story on 14/10/2023.
//

import UIKit

class ImageDetailVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var smallImageCollectionView: UICollectionView!
    @IBOutlet weak var vSmallImageContainer: UIView!
    @IBOutlet weak var vContent: UIView!
    var dataSource:[UIImage] = []
    var atIndex: Int?
    var smallContainerIsHidden = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }
    
    func bindingData(dataSource:[UIImage], atIndex: Int ) {
        self.dataSource = dataSource
        self.atIndex = atIndex
    }
    
    @IBAction func dismissOnTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        
        smallImageCollectionView.delegate = self
        smallImageCollectionView.dataSource = self
        smallImageCollectionView.register(UINib(nibName: "SmallImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "smallImageCell")
    }
    @objc func toShowAndHide() {
        smallContainerIsHidden = !smallContainerIsHidden
        UIView.animate(withDuration: 0.25) {
            if self.smallContainerIsHidden {
                self.vSmallImageContainer.alpha = 0
            } else {
                self.vSmallImageContainer.alpha = 0
            }
            self.view.layoutIfNeeded()
        }
    }
}
extension ImageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == smallImageCollectionView {
            return dataSource.count
        } else {
            return dataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == smallImageCollectionView {
            let smallImage = collectionView.dequeueReusableCell(withReuseIdentifier: "smallImageCell", for: indexPath) as! SmallImageCollectionViewCell
            smallImage.bindingUI(image: dataSource[indexPath.row] )
            smallImage.ivImage.contentMode = .scaleAspectFill
            return smallImage
        } else {
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            imageCell.bindingUI(image: dataSource[atIndex ?? 0])
            imageCell.ivItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toShowAndHide)))
            return imageCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == smallImageCollectionView {
            if let newImage = self.collectionView.cellForItem(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? ImageCollectionViewCell {
                newImage.bindingUI(image: dataSource[indexPath.row])
                self.collectionView.reloadData()

            }
            print(indexPath.row)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == smallImageCollectionView {
            let height = vSmallImageContainer.frame.height
            let width = 30.0
            return CGSize(width: width, height: height)
        } else {
            let height = vContent.frame.height
            let width = UIScreen.main.bounds.width
            return CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == smallImageCollectionView {
            return 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == smallImageCollectionView {
            return 1
        } else {
            return 1
        }
    }
}
