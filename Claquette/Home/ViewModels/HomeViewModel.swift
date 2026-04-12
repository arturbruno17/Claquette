//
//  HomeViewModel.swift
//  Claquette
//
//  Created by Artur Bruno on 05/04/26.
//

import UIKit
import Observation

@Observable
class HomeViewModel {
    
    private let titlesRepository: TitlesRepository
    
    private(set) var homeUiState: HomeUIState = .loading
    
    init(titlesRepository: TitlesRepository = .init()) {
        self.titlesRepository = titlesRepository
    }
    
    @objc func getTitles() {
        Task {
            do {
                let response = try await titlesRepository.listTitles()
                let titlesArray = response.titles
                let banners = Array(titlesArray.prefix(5))
                let remaining = titlesArray.dropFirst(min(5, titlesArray.count))
                let otherTitles = Dictionary(grouping: remaining, by: { $0.genres?.first ?? "Others" })
                homeUiState = .success(banners, otherTitles)
            } catch {
                homeUiState = .error(error)
            }
        }
    }
}

