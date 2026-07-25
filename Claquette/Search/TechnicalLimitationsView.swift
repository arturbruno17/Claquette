//
//  TechnicalLimitationsView.swift
//  Claquette
//
//  Created by Artur Bruno on 03/05/26.
//

import UIKit

class TechnicalLimitationsView: UIStackView {

    private let warningSymbol: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "exclamationmark.circle"))
        image.tintColor = .accent
        return image
    }()
    
    private let warningText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Due to technical limitations, you can only search by title or by applying filters."
        label.font = UIFont(name: UIFont.interRegular, size: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    init() {
        super.init(frame: .zero)

        axis = .horizontal
        spacing = 16
        alignment = .center
        layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        isLayoutMarginsRelativeArrangement = true
        
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addArrangedSubview(warningSymbol)
        addArrangedSubview(warningText)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            warningSymbol.widthAnchor.constraint(equalToConstant: 20),
            warningSymbol.heightAnchor.constraint(equalToConstant: 22),
        ])
    }

}
