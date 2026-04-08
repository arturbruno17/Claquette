//
//  BannerView.swift
//  Claquette
//
//  Created by Artur Bruno on 02/04/26.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    
    static let identifier = "BannerViewCell"
    
    private let gradientLayer = CAGradientLayer()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let asyncImage: UIAsyncImage = {
        let asyncImage = UIAsyncImage()
        asyncImage.translatesAutoresizingMaskIntoConstraints = false
        asyncImage.imageView.contentMode = .scaleAspectFill
        asyncImage.clipsToBounds = true
        return asyncImage
    }()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = .init(name: UIFont.interBold, size: 24)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let genresView: UILabel = {
        let label = UILabel()
        label.font = .init(name: UIFont.interRegular, size: 14)
        label.textColor = .white
        return label
    }()
    
    private let releaseYearAndAgeIndicationStack = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        return stackView
    }()
    
    private let releaseYearView: UILabel = {
        let label = UILabel()
        label.font = .init(name: UIFont.interRegular, size: 12)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        configureBannerGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = overlayView.bounds
    }
    
    override func prepareForReuse() {
        titleView.text = ""
        genresView.text = ""
        releaseYearView.text = ""

        let oldView = releaseYearAndAgeIndicationStack.arrangedSubviews[1]
        releaseYearAndAgeIndicationStack.removeArrangedSubview(oldView)
        oldView.removeFromSuperview()
    }
    
    func configure(imageUrl: String, title: String, genres: [String], releaseYear: String, ageIndication: AgeIndicationView) {
        if let url = URL(string: imageUrl) { asyncImage.url = url }
        
        titleView.text = title
        
        let genresToDisplay = genres.count > 3 ? Array(genres[0...2]) : genres
        genresView.text = genresToDisplay.joined(separator: ", ")
        
        releaseYearView.text = releaseYear
        releaseYearAndAgeIndicationStack.addArrangedSubview(ageIndication)
    }
    
    private func setupViews() {
        addSubview(asyncImage)
        addSubview(contentStack)
        asyncImage.addSubview(overlayView)
        contentStack.addArrangedSubview(titleView)
        contentStack.addArrangedSubview(genresView)
        contentStack.addArrangedSubview(releaseYearAndAgeIndicationStack)
        releaseYearAndAgeIndicationStack.addArrangedSubview(releaseYearView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            asyncImage.topAnchor.constraint(equalTo: topAnchor),
            asyncImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            asyncImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            asyncImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: asyncImage.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: asyncImage.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: asyncImage.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: asyncImage.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -44),
        ])
    }
    
    private func configureBannerGradient() {
        gradientLayer.colors = [
            UIColor.bannerGradientLight.cgColor,
            UIColor.bannerGradientDark.cgColor
        ]
        gradientLayer.locations = [0.0, 0.63]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        overlayView.layer.insertSublayer(gradientLayer, at: 0)
    }
}

