//
//  BannerCarouselView.swift
//  Claquette
//
//  Created by Artur Bruno on 06/04/26.
//

import UIKit

extension BannerCarouselView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewCell.identifier, for: indexPath)
                as? BannerViewCell else {
            fatalError("dequeueReusableSupplementaryView(identifier:indexPath) must return a BannerViewCell instance")
        }
        let imdbTitle = titles[indexPath.row]
        cell.configure(
            imageUrl: imdbTitle.primaryImage?.url ?? "",
            title: imdbTitle.primaryTitle ?? "",
            genres: imdbTitle.genres ?? [],
            releaseYear: imdbTitle.startYear?.description ?? "",
            ageIndication: .free
        )
        return cell
    }
}
