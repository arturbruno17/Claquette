//
//  BannerCarouselView.swift
//  Claquette
//
//  Created by Artur Bruno on 06/04/26.
//

import UIKit

class BannerCarouselView : UIView {
    
    var titles: [IMDbTitle] = [] {
        didSet {
            pageControl.numberOfPages = titles.count
            collectionView.reloadData()
        }
    }
    
    private(set) lazy var itemSize = {
        CGSize(width: CGRectGetWidth(UIScreen.main.bounds), height: 350)
    }()
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = itemSize
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .clear
        view.isPagingEnabled = false
        view.contentInsetAdjustmentBehavior = .never
        view.decelerationRate = .fast
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.register(BannerViewCell.self, forCellWithReuseIdentifier: BannerViewCell.identifier)
        return view
    }()
    
    private(set) lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        return pageControl
    }()
    
    init(titles: [IMDbTitle] = []) {
        self.titles = titles
        super.init(frame: .zero)
        setupCollectionView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.dataSource = self
        
        addSubview(pageControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -10),
        ])
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        
        let cellWidth = itemSize.width
        let targetOffset = cellWidth * CGFloat(page)
        
        collectionView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: true)
    }
}
