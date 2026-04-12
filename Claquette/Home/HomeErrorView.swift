//
//  HomeErrorView.swift
//  Claquette
//
//  Created by Artur Bruno on 11/04/26.
//

import UIKit

class HomeErrorView : UIView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    private let imageView: UIImageView = {
        let original = UIImage.claquette
        let gray = original.grayscale() ?? original
        let imageView = UIImageView(image: gray)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pageNotLoadedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.interRegular, size: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Catalog could not be loaded."
        return label
    }()
    
    private let tryAgainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.interRegular, size: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Please, try again."
        return label
    }()
    
    let tryAgainButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Try again"
        configuration.baseBackgroundColor = .accent
        configuration.baseForegroundColor = .white
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
    
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.setCustomSpacing(16, after: imageView)
        stackView.addArrangedSubview(pageNotLoadedLabel)
        stackView.addArrangedSubview(tryAgainLabel)
        stackView.setCustomSpacing(16, after: tryAgainLabel)
        stackView.addArrangedSubview(tryAgainButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90)
        ])
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
extension UIImage {
    func grayscale() -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        // Use Core Image to apply a monochrome filter for accurate grayscale
        guard let ciImage = CIImage(image: self) else { return nil }
        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(0.0, forKey: kCIInputSaturationKey)
        guard let output = filter?.outputImage,
              let cgImage = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        // Draw into a context matching the original image scale and orientation
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation).draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

