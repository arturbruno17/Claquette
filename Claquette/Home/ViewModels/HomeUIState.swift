//
//  HomeUIState.swift
//  Claquette
//
//  Created by Artur Bruno on 05/04/26.
//

import UIKit

enum HomeUIState {
    case loading
    case error(Error)
    case success([IMDbTitle], [String : [IMDbTitle]])
}
