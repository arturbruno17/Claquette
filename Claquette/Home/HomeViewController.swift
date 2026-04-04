//
//  HomeViewController.swift
//  Claquette
//
//  Created by Artur Bruno on 02/04/26.
//

import UIKit

class HomeViewController: UIViewController {

    private let gradientLayer = CAGradientLayer()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bannerView)
        view.addSubview(pageControl)

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
    }
}
