////
////  File.swift
////  QuyCookkTeam
////
////  Created by Hartzed Story on 14/10/2023.
////
//
//import Foundation
//extension MTCSeatSelectionViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        miniMap.isHidden = false
//        miniMap.update(animated: true)
//    }
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        miniMap.isHidden = false
//        miniMap.update(animated: true)
//    }
//    
//    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//        miniMap.isHidden = true
//        miniMap.update(animated: true)
//    }
//    
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        miniMap.isHidden = true
//        miniMap.update(animated: true)
//    }
//    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return vContent
//    }
//}
//
//
//override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//    coordinator.animate(alongsideTransition: { [weak self] _ in
//        guard let self = self else { return }
//        self.centerContentView(in: self.scrollView)
//        self.miniMap.addDropShadow()
//    }, completion: nil)
//}
//func configScrollView() {
//    scrollView.delegate = self
//    scrollView.minimumZoomScale = 1.0
//    scrollView.maximumZoomScale = 10.0
//    scrollView.showsHorizontalScrollIndicator = false
//    scrollView.showsVerticalScrollIndicator = false
//}
//
//func centerContentView(in scrollView: UIScrollView) {
//    // Centers the content view if it is smaller than the scroll view frame.
//    let leftOffset = max((scrollView.bounds.width - scrollView.contentSize.width) / 2, 0)
//    let topOffset = max((scrollView.bounds.height - scrollView.contentSize.height) / 2, 0)
//    scrollView.contentInset = UIEdgeInsets(top: topOffset, left: leftOffset, bottom: 0, right: 0)
//}
//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    centerContentView(in: scrollView)
//}
