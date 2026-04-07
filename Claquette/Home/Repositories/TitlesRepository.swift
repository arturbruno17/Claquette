//
//  TitlesRepository.swift
//  Claquette
//
//  Created by Artur Bruno on 05/04/26.
//

import Foundation

final class TitlesRepository {
    
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    enum APIError: Error { case invalidURL, requestFailed, decodingFailed }

    private let baseURL = URL(string: "https://api.imdbapi.dev")

    func listTitles() async throws -> ListTitlesResponse {
        guard let titlesUrl = baseURL?.appending(path: "titles") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await urlSession.data(from: titlesUrl)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw APIError.requestFailed
        }
        
        do {
            return try jsonDecoder.decode(ListTitlesResponse.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
