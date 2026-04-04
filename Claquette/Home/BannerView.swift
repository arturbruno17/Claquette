//
//  BannerView.swift
//  Claquette
//
//  Created by Artur Bruno on 02/04/26.
//

import UIKit

class BannerView: UIView {
    
    var title: String = "" {
        didSet { titleView.text = title }
    }
    
    var genres: [String] = [] {
        didSet { genresView.text = genres.joined(separator: ", ") }
    }
    
    var releaseYear: String = "" {
        didSet { releaseYearView.text = releaseYear }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
    
    var ageIndicationView: AgeIndicationView = .free {
        willSet {
            releaseYearAndAgeIndicationStack.removeArrangedSubview(ageIndicationView)
        }
        didSet {
            releaseYearAndAgeIndicationStack.addArrangedSubview(ageIndicationView)
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
        configureBannerGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = imageView.bounds
    }
    
    func configure(image: UIImage, title: String, genres: [String], releaseYear: String, ageIndication: AgeIndicationView) {
        self.title = title
        self.genres = genres
        self.releaseYear = releaseYear
        self.ageIndicationView = ageIndication
        self.imageView.image = image
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(contentStack)
        contentStack.addArrangedSubview(titleView)
        contentStack.addArrangedSubview(genresView)
        contentStack.addArrangedSubview(releaseYearAndAgeIndicationStack)
        releaseYearAndAgeIndicationStack.addArrangedSubview(releaseYearView)
        releaseYearAndAgeIndicationStack.addArrangedSubview(ageIndicationView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
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
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)

        imageView.layer.insertSublayer(gradientLayer, at: 0)
    }
}

