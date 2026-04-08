//
//  TitleCollectionViewCell.swift
//  Claquette
//
//  Created by Artur Bruno on 04/04/26.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let asyncImage: UIAsyncImage = {
        let asyncImage = UIAsyncImage()
        asyncImage.imageView.contentMode = .scaleAspectFill
        asyncImage.translatesAutoresizingMaskIntoConstraints = false
        asyncImage.clipsToBounds = true
        asyncImage.layer.cornerRadius = 8
        return asyncImage
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.interSemiBold, size: 16)
        label.textColor = .secondaryLabel.withAlphaComponent(1)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleView.text = nil
    }
    
    func configure(with imdbTitle: IMDbTitle) {
        titleView.text = imdbTitle.primaryTitle ?? ""

        guard let primaryImage = imdbTitle.primaryImage?.url,
              let imageUrl = URL(string: primaryImage) else { return }

        asyncImage.url = imageUrl
    }
    
    private func setupViews() {
        contentView.addSubview(stack)
        stack.addArrangedSubview(asyncImage)
        stack.addArrangedSubview(titleView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            asyncImage.widthAnchor.constraint(equalToConstant: 150),
            asyncImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
