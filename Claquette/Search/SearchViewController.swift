//
//  SearchViewController.swift
//  Claquette
//
//  Created by Artur Bruno on 03/05/26.
//

import UIKit

class SearchViewController: UIViewController {
    
    enum State {
        case initial, empty, loaded, error
    }
    
    private var state: State = .initial {
        didSet { exhibitAppropriateViews() }
    }
   
    private let searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search for titles"
        searchTextField.leftView?.tintColor = .secondaryLabel
        searchTextField.backgroundColor = .secondarySystemFill
        
        let icon = UIImageView(image: UIImage(systemName: "slider.horizontal.3"))
        icon.tintColor = .secondaryLabel
        searchTextField.rightView = icon
        searchTextField.rightViewMode = .always
        
        return searchTextField
    }()
    
    private let technicalLimitationsView: TechnicalLimitationsView = {
        let technicalLimitationsView = TechnicalLimitationsView()
        technicalLimitationsView.translatesAutoresizingMaskIntoConstraints = false
        return technicalLimitationsView
    }()
    
    private let noTitlesLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No titles with the provided filters."
        label.font = UIFont(name: UIFont.interRegular, size: 20)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let errorView: UIErrorView = {
        let errorView = UIErrorView()
        errorView.isHidden = true
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(searchTextField)
        view.addSubview(technicalLimitationsView)
        view.addSubview(noTitlesLabel)
        view.addSubview(errorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        NSLayoutConstraint.activate([
            technicalLimitationsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            technicalLimitationsView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            technicalLimitationsView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            noTitlesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noTitlesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func exhibitAppropriateViews() {
        technicalLimitationsView.isHidden = state != .initial
        noTitlesLabel.isHidden = state != .empty
        errorView.isHidden = state != .error
    }

}
