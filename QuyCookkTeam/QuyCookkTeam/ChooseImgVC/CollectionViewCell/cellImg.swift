//
//  cellImg.swift
//  QuyCookkTeam
//
//  Created by Duy Tran on 14/10/2023.
//

import UIKit

class cellImg: UICollectionViewCell {

    @IBOutlet weak var vImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindingData(img: UIImage) {
        vImg.image = img
        
    }
    @IBAction func selectAction(_ sender: Any) {
        print("Selected")
    }
}
