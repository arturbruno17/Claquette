import Foundation

public struct ListTitlesResponse: Decodable {
    public let titles: [IMDbTitle]
    public let totalCount: Int?
    public let nextPageToken: String?
}

public struct IMDbTitle: Decodable {
    public let id: String
    public let type: String?
    public let isAdult: Bool?
    public let primaryTitle: String?
    public let originalTitle: String?
    public let primaryImage: IMDbImage?
    public let startYear: Int?
    public let endYear: Int?
    public let runtimeSeconds: Int?
    public let genres: [String]?
    public let rating: IMDbRating?
    public let metacritic: IMDbMetacritic?
    public let plot: String?
    public let directors: [IMDbName]?
    public let writers: [IMDbName]?
    public let stars: [IMDbName]?
    public let originCountries: [IMDBCoutry]?
    public let spokenLanguages: [IMDBLanguage]?
    public let interests: [IMDBInterest]?
}

public struct IMDbImage: Decodable {
    public let url: String?
    public let width: Int?
    public let height: Int?
    public let type: String?
}

public struct IMDbRating: Decodable {
    public let aggregateRating: Double?
    public let voteCount: Int?
}

public struct IMDbMetacritic: Decodable {
    public let url: String?
    public let score: Int?
    public let reviewCount: Int?
}

public struct IMDBCoutry: Decodable {
    public let code: String?
    public let name: String?
}

public struct IMDBLanguage: Decodable {
    public let code: String?
    public let name: String?
}

public struct IMDbName: Decodable {
    public let id: String?
    public let displayName: String?
    public let alternativeNames: [String]?
    public let primaryImage: IMDbImage?
    public let primaryProfessions: [String]?
    public let biography: String?
    public let heightCm: Int?
    public let birthName: String?
    public let birthDate: IMDbPrecisionDate?
    public let birthLocation: String?
    public let deathDate: IMDbPrecisionDate?
    public let deathLocation: String?
    public let deathReason: String?
}

public struct IMDBInterest: Decodable {
    public let id: String?
    public let name: String?
    public let primaryImage: IMDbImage?
    public let description: String?
    public let isSubgenre: Bool?
    public let similarInterests: [IMDBInterest]?
}

public struct IMDbPrecisionDate: Decodable {
    public let year: Int?
    public let month: Int?
    public let day: Int?
}
