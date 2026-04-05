//
//  HomeViewController.swift
//  Claquette
//
//  Created by Artur Bruno on 02/04/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    let bannerView: BannerView = {
        let bannerView = BannerView()
        bannerView.configure(
            image: .bannerPlacholder,
            title: "Project Hail Mary",
            genres: ["Adventure", "Comedy", "Sci-Fi"],
            releaseYear: "2026",
            ageIndication: .free
        )
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        return bannerView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    lazy var otherTitlesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.createHomeListLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            TitleCollectionViewCell.self,
            forCellWithReuseIdentifier: TitleCollectionViewCell.identifier
        )
        collectionView.register(
            GenreSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "GenreSectionHeaderView"
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bannerView)
        view.addSubview(pageControl)
        view.addSubview(otherTitlesCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 350)
        ])
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
            otherTitlesCollectionView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 20),
            otherTitlesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            otherTitlesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            otherTitlesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
