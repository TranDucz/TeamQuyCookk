//
//  ImageCollectionViewCell.swift
//  QuyCookkTeam
//
//  Created by Hartzed Story on 14/10/2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivItem: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
    func bindingUI() {
        
    }
}
extension ImageCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ivItem
    }
}
