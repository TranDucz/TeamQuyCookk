//
//  cellImg.swift
//  QuyCookkTeam
//
//  Created by Duy Tran on 14/10/2023.
//

import UIKit

class cellImg: UICollectionViewCell {

    @IBOutlet weak var vSelect: UIView!
    @IBOutlet weak var vImg: UIImageView!
    @IBOutlet weak var vAlpha: UIView!
    @IBOutlet weak var lblSelect: UILabel!
    
    var indexPath: IndexPath = [] {
        didSet {
            if let index =  lstSelected.firstIndex { $0 == indexPath } {
                lblSelect.text = "\(index + 1)"
            }
            
        }
    }
    var onClickSelect:(() -> Void)?
    var isSelectedCell: Bool = false
    var lstSelected: [IndexPath] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()

        vSelect.layer.cornerRadius = 12
        vSelect.layer.borderWidth = 2
        vSelect.layer.borderColor = UIColor.white.cgColor
        vSelect.backgroundColor = UIColor.clear
    }

    func bindingData(img: UIImage) {
        vImg.image = img
        
    }
    
    func setIsSelect(isSelect:Bool) {
        vSelect.backgroundColor = isSelect ? UIColor.clear : UIColor(red: 30/255, green: 139/255, blue: 247/255, alpha: 1)
        vAlpha.backgroundColor = UIColor.black
        vAlpha.alpha = 0.6
        vAlpha.isHidden = isSelect
        lblSelect.isHidden = isSelect
        isSelectedCell = isSelect

    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        self.setIsSelect(isSelect: sender.isSelected)
        sender.isSelected = !sender.isSelected
        if let onClickSelect = onClickSelect {
            onClickSelect()
        }
    }
}
