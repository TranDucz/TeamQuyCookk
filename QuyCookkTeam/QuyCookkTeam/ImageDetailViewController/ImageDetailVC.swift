//
//  ImageDetailVC.swift
//  QuyCookkTeam
//
//  Created by Hartzed Story on 14/10/2023.
//

import UIKit

class ImageDetailVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
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
    }
}
extension ImageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = vContent.frame.height
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
    
}
