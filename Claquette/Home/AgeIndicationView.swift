//
//  AgeIndicationView.swift
//  Claquette
//
//  Created by Artur Bruno on 03/04/26.
//

import UIKit

class AgeIndicationView : UILabel {
    
    private init(text: String, backgroundColor: UIColor) {
        super.init(frame: .zero)

        self.text = text
        self.backgroundColor = backgroundColor
        
        font = UIFont(name: UIFont.interBold, size: 12)
        textAlignment = .center
        textColor = .white
        
        clipsToBounds = true
        layer.cornerRadius = 4

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 16),
            heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}

extension AgeIndicationView {
    static var free: AgeIndicationView { .init(text: "L", backgroundColor: .ageIndicationFree) }
    static var a10: AgeIndicationView { .init(text: "10", backgroundColor: .ageIndication10) }
    static var a12: AgeIndicationView { .init(text: "12", backgroundColor: .ageIndication12) }
    static var a14: AgeIndicationView { .init(text: "14", backgroundColor: .ageIndication14) }
    static var a16: AgeIndicationView { .init(text: "16", backgroundColor: .ageIndication16) }
    static var a18: AgeIndicationView { .init(text: "18", backgroundColor: .ageIndication18) }
}
