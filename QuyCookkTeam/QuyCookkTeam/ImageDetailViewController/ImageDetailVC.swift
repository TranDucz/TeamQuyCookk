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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        
        smallImageCollectionView.delegate = self
        smallImageCollectionView.dataSource = self
        smallImageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "smallImageCell")
    }
}
extension ImageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == smallImageCollectionView {
            return 10
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == smallImageCollectionView {
            let smallImage = collectionView.dequeueReusableCell(withReuseIdentifier: "smallImageCell", for: indexPath) as! ImageCollectionViewCell
            return smallImage
        } else {
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            return imageCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == smallImageCollectionView {
            let height = vSmallImageContainer.frame.height
            let width = height * 1.5
            return CGSize(width: width, height: height)
        } else {
            let height = vContent.frame.height
            let width = UIScreen.main.bounds.width
            return CGSize(width: width, height: height)
        }
    }
}
