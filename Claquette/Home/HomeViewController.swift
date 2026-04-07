//
//  HomeViewController.swift
//  Claquette
//
//  Created by Artur Bruno on 02/04/26.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource {
    
    private let homeViewModel: HomeViewModel
    
    let carouselView: BannerCarouselView = {
        let bannerView = BannerCarouselView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        return bannerView
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
            withReuseIdentifier: GenreSectionHeaderView.identifier
        )
        return collectionView
    }()
    
    init(homeViewModel: HomeViewModel = .init()) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(carouselView)
        view.addSubview(otherTitlesCollectionView)
        
        setupConstraints()
        setupObservers()
        
        homeViewModel.getTitles()
    }
    
    func setupObservers() {
        withObservationTracking({ @MainActor in
            switch (homeViewModel.homeUiState) {
            case .success(let imdbBannerTitles, _):
                carouselView.titles = imdbBannerTitles
                otherTitlesCollectionView.reloadData()
                break
            default:
                break
            }
        }, onChange: {
            Task { @MainActor in
                self.setupObservers()
            }
        })
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carouselView.topAnchor.constraint(equalTo: view.topAnchor),
            carouselView.heightAnchor.constraint(equalToConstant: 350)
        ])
        NSLayoutConstraint.activate([
            otherTitlesCollectionView.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 20),
            otherTitlesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            otherTitlesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            otherTitlesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard case .success(_, let titlesByGenre) = homeViewModel.homeUiState else {
            return 0
        }
        return titlesByGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard case .success(_, let titlesByGenre) = homeViewModel.homeUiState else {
            return 0
        }
        let genres = titlesByGenre.keys.sorted(by: <)
        let genre = genres[section]
        return titlesByGenre[genre]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let genreSectionHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: GenreSectionHeaderView.identifier,
            for: indexPath
        ) as? GenreSectionHeaderView else {
            fatalError("dequeueReusableSupplementaryView(elementKind:identifier:indexPath) must return a GenreSectionHeaderView instance")
        }
        if case .success(_, let titlesByGenre) = homeViewModel.homeUiState {
            let genres = titlesByGenre.keys.sorted(by: <)
            let genre = genres[indexPath.section]
            genreSectionHeader.configure(genre: genre)
        }
        return genreSectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TitleCollectionViewCell.identifier,
            for: indexPath
        ) as? TitleCollectionViewCell else {
            fatalError("dequeueReusableCell(identifier:indexPath) must return a TitleCollectionViewCell instance")
        }
        
        if case .success(_, let titlesByGenre) = homeViewModel.homeUiState {
            let genres = titlesByGenre.keys.sorted(by: <)
            let genre = genres[indexPath.section]
            let titles = titlesByGenre[genre]
            guard let title = titles?[indexPath.row] else { return cell }
            cell.configure(with: title)
        }
        
        return cell
    }
}

