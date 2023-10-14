//
//  ViewController.swift
//  QuyCookkTeam
//
//  Created by Duy Tran on 14/10/2023.
//

import UIKit
import Photos
class ViewController: UIViewController {
    var dataSource: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
    }
    
    fileprivate func getPhotos() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        // .highQualityFormat will return better quality photos
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if results.count > 0 {
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 700, height: 700)
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        self.dataSource.append(image)
                    } else {
                        print("error asset to image")
                    }
                }
            }
        } else {
            print("no photos to display")
        }

    }
    @IBAction func testPresent(_ sender: Any) {
        let detailView = ImageDetailVC()
        detailView.modalPresentationStyle = .overFullScreen
        self.present(detailView,animated: true)
    }
}
