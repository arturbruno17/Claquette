//
//  AsyncUIImage+DefaultPlaceholder.swift
//  Claquette
//
//  Created by Artur Bruno on 06/04/26.
//

import UIKit

extension UIAsyncImage {
    static var defaultPlaceholder: UIView {
        let container = UIView()
        container.backgroundColor = .systemGray5
        container.translatesAutoresizingMaskIntoConstraints = false
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()

        container.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }

    static var defaultErrorView: UIView {
        let container = UIView()
        container.backgroundColor = .systemGray5
        container.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular)
        imageView.tintColor = .systemGray
        imageView.image = UIImage(systemName: "photo")

        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }
}

