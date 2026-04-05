//
//  HomeViewController+UICollectionViewDataSource.swift
//  Claquette
//
//  Created by Artur Bruno on 04/04/26.
//

import UIKit

extension HomeViewController : UICollectionViewDataSource {
    
    static let identifier = "General"
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let genreSectionHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: GenreSectionHeaderView.identifier,
            for: indexPath
        ) as? GenreSectionHeaderView else {
            fatalError("dequeueReusableSupplementaryView(elementKind:identifier:indexPath) must return a GenreSectionHeaderView instance")
        }
        genreSectionHeader.configure(genre: "Sci-Fi")
        return genreSectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TitleCollectionViewCell.identifier,
            for: indexPath
        )
        return cell 
    }
    
    
}
