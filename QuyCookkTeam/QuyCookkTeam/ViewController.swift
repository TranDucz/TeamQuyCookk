//
//  ViewController.swift
//  QuyCookkTeam
//
//  Created by Duy Tran on 14/10/2023.
//

import UIKit
import Photos

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
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func getPhotos() {
        
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
//        requestOptions.deliveryMode = .highQualityFormat
        // .highQualityFormat will return better quality photos
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        DispatchQueue.main.async {
            let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            if results.count > 0 {
                for i in 0..<results.count {
                    let asset = results.object(at: i)
                    let size = CGSize(width: 700, height: 700)
                    manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                        if let image = image {
                            self.images.append(image)
                        } else {
                            print("error asset to image")
                        }
                    }
                }
            } else {
                print("no photos to display")
            }
        }
        
        
    }
    func allImg() {

    }
    
    func getAllImg() {
        let options = PHFetchOptions()
        options.includeHiddenAssets = false
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] // Newest first
        options.predicate = NSPredicate(format: "mediaType = \(PHAssetMediaType.image.rawValue)") // Only images

        DispatchQueue.main.async {
            self.mediaAssets = PHAsset.fetchAssets(with: options)
            
        }
    }
    
    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            // Quyền truy cập đã được cấp, bạn có thể lưu ảnh vào thư viện ảnh ở đây.
           getAllImg()
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

