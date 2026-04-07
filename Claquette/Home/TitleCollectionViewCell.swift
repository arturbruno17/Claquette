//
//  TitleCollectionViewCell.swift
//  Claquette
//
//  Created by Artur Bruno on 04/04/26.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private var imageDownloadTask: Task<Void, Never>? = nil
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: .bannerPlacholder)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.image = .init(systemName: "photo")
        imageView.tintColor = .secondaryLabel
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.interSemiBold, size: 16)
        label.text = "Project Hail Mary"
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
        imageDownloadTask?.cancel()
        imageDownloadTask = nil
        imageView.image = .bannerPlacholder
        titleView.text = nil
    }
    
    func configure(with imdbTitle: IMDbTitle) {
        titleView.text = imdbTitle.primaryTitle ?? ""

        guard let primaryImage = imdbTitle.primaryImage?.url,
              let imageUrl = URL(string: primaryImage) else { return }

        imageDownloadTask?.cancel()
        imageDownloadTask = Task(priority: .utility) {
            do {
                let (data, _) = try await URLSession.shared.data(from: imageUrl)
                
                try Task.checkCancellation()
    
                let decodedImage = await withCheckedContinuation { continuation in
                    let image = UIImage(data: data)
                    continuation.resume(returning: image)
                }
                guard let image = decodedImage else { return }
                await MainActor.run { self.imageView.image = image }
            } catch {
                // Swallow cancellation and network errors silently for now
            }
        }
    }
    
    private func setupViews() {
        contentView.addSubview(stack)
        stack.addArrangedSubview(imageView)
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
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
