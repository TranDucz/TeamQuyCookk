//
//  ViewController.swift
//  QuyCookkTeam
//
//  Created by Duy Tran on 14/10/2023.
//

import UIKit
import Photos
import CoreImage
class ViewController: UIViewController {
    
    var images = [UIImage]()
    var mediaAssets: PHFetchResult<PHAsset>? = nil
    var allPhotos : PHFetchResult<PHAsset>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestPhotoLibraryAccess()
    }
    
    
    @IBAction func chooseImgAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "ChooseImgVC", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChooseImgVC") as! ChooseImgVC
        vc.lstImg = images
        self.navigationController?.present(vc, animated: true)
    }
    
    func getAllImg() {
        let options = PHFetchOptions()
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
        
        let albumName = userAlbums.firstObject?.localizedTitle
        let fetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        let imageManager = PHCachingImageManager()
        for i in 0..<fetchResult.count {
            let album = fetchResult[i]
            if album.localizedTitle == albumName {
                // You've found the album with the specified name
                let albumIdentifier = album.localIdentifier
                print("Album Identifier: \(albumIdentifier)")
                fetchResult.enumerateObjects { (collection, index, stop) in
                    if collection.localIdentifier == albumIdentifier {
                        let userPhotos = PHAsset.fetchAssets(in: collection, options: nil)
                        userPhotos.enumerateObjects { nObjc, _, _ in
                            let obj:PHAsset = nObjc as! PHAsset
                            let options = PHImageRequestOptions()
                            options.deliveryMode = .highQualityFormat
                            options.isSynchronous = true
                            
                            imageManager.requestImage(for: obj, targetSize: CGSize(width: obj.pixelWidth, height: obj.pixelHeight), contentMode: .aspectFill, options: options, resultHandler: { img, info in
                                self.images.append(img!)
                            })
                        }
                        
                        
                        
                        print("UserPhotos = \(userPhotos)")
                        stop.pointee = true
                    }
                }
                print("Album = \(album)")
                break
            }
        }
    
    }
    
    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            // Quyền truy cập đã được cấp, bạn có thể lưu ảnh vào thư viện ảnh ở đây.
            let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
            assets.enumerateObjects { object, _, _ in
                print(object)
            }

            self.getAllImg()
        case .denied, .restricted:
            
                let alert = UIAlertController(
                    title: "Yêu cầu quyền truy cập",
                    message: "Ứng dụng cần truy cập thư viện ảnh để lưu ảnh chụp màn hình. Vui lòng cho phép truy cập trong cài đặt ứng dụng.",
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "Mở Cài Đặt", style: .default, handler: { _ in
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Từ chối", style: .cancel, handler: { _ in
                }))
                
                // Hiển thị thông báo yêu cầu quyền truy cập.
                present(alert, animated: true, completion: nil)
            
            
        case .notDetermined:
            // Quyền truy cập chưa được xác định. Yêu cầu quyền truy cập.
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        self.requestPhotoLibraryAccess()
                    } else {
                        // Người dùng từ chối cấp quyền truy cập.
                        // Bạn có thể xử lý tùy thuộc vào trường hợp này.
                        print("Người dùng từ chối cấp quyền truy cập")
                    }
                }
            }
        case .limited:
            break
        @unknown default:
            break
        }
    }
}
extension UIImageView{
 func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
    let options = PHImageRequestOptions()
    options.version = .original
    PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
        guard let image = image else { return }
        switch contentMode {
        case .aspectFill:
            self.contentMode = .scaleAspectFill
        case .aspectFit:
            self.contentMode = .scaleAspectFit
        }
        self.image = image
    }
   }
}
