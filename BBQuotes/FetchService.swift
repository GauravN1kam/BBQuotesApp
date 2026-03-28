import Foundation

struct FetchService {
    private enum FetchError: Error {
        case badResponce
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        // Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // handle responce
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
            throw FetchError.badResponce
        }
        
        // Decode data
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return quote
        return quote
    }
    
    func fetchCharacter(_ name: String,) async throws -> Char {
        let charaterURL = baseURL.appending(path: "characters")
        let fetchURL = charaterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponce
        }
        
        let decoder = JSONDecoder();
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let character = try decoder.decode([Char].self, from: data)
        
        
        return character[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponce
        }
        
        let decoder = JSONDecoder();
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.charactor.lowercased() == character.lowercased() {
                return death
            }
        }
        
        return nil
    }
}
