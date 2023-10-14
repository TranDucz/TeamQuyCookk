//
//  ChooseImgVC.swift
//  QuyCookkTeam
//
//  Created by Duy Tran on 14/10/2023.
//

import UIKit

class ChooseImgVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var lstImg:[UIImage] = []
    var lstSelected:[IndexPath] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName:"cellImg", bundle: nil), forCellWithReuseIdentifier: "cellImg")
    }


}

extension ChooseImgVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lstImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImg", for: indexPath) as! cellImg
        cell.bindingData(img: lstImg[indexPath.row])
        cell.onClickSelect = {
            if self.lstSelected.contains(where: { $0 == indexPath }) {
                self.lstSelected = self.lstSelected.filter({ $0 != indexPath })
            } else {
                self.lstSelected.append(indexPath)
            }
            cell.lstSelected = self.lstSelected
            cell.indexPath = indexPath
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = CGFloat(3 + 1) * 2
        let a = collectionView.frame.width
        let availabelWith = a - padding
        let size = availabelWith / 3
        
        return CGSize(width: size, height: size)
    }
    
    
}
