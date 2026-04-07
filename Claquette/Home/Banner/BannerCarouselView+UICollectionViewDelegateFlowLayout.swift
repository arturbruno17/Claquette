//
//  BannerCarouselView+UICollectionViewDelegateFlowLayout.swift
//  Claquette
//
//  Created by Artur Bruno on 06/04/26.
//

import UIKit

extension BannerCarouselView : UICollectionViewDelegateFlowLayout {
    
    func updatePageControlFromScroll() {
        let cellWidth = itemSize.width
        let scrolledOffsetX = collectionView.contentOffset.x
        let page = Int(scrolledOffsetX / cellWidth)
        
        if page >= 0 && page < titles.count && pageControl.currentPage != page {
            pageControl.currentPage = page
        }
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x
        let cellWidth = itemSize.width
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth, y: scrollView.contentInset.top)
        
        let targetPage = Int(index)
        if targetPage >= 0 && targetPage < titles.count {
            pageControl.currentPage = targetPage
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControlFromScroll()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageControlFromScroll()
    }
    
}
