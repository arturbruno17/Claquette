//
//  GenreSectionHeaderView.swift
//  Claquette
//
//  Created by Artur Bruno on 04/04/26.
//

import UIKit

class GenreSectionHeaderView: UICollectionReusableView {
    
    static let identifier = "GenreSectionHeaderView"
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.interSemiBold, size: 24)
        return label
    }()
    
    private let showMoreView: UILabel = {
        let label = UILabel()
        var attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        attributes[.font] = UIFont(name: UIFont.interRegular, size: 14)
        attributes[.foregroundColor] = UIColor.accent
        label.attributedText = NSAttributedString(string: "Show more", attributes: attributes)
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
    
    func configure(genre: String) {
        titleView.text = genre
    }
    
    private func setupViews() {
        addSubview(stack)
        stack.addArrangedSubview(titleView)
        stack.addArrangedSubview(showMoreView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
