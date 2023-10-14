//
//  SmallImageCollectionViewCell.swift
//  QuyCookkTeam
//
//  Created by Hartzed Story on 14/10/2023.
//

import UIKit

class SmallImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivImage: UIImageView!
    override func prepareForReuse() {
        self.ivImage.image = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindingUI(image: UIImage) {
        self.ivImage.image = image
    }
}
