//
//  Service.swift
//  FortniteHome
//
//  Created by Артем Ластович on 16.04.2022.
//

import Foundation

struct Service  {
    
    enum ServiceError: Error {
        case badUrl, fetchFailed, decodeFailed
    }
    
    func fetchData<T: Codable>(url: String) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw ServiceError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.setValue("0fc4c718-a951-4608-8d63-cffe514d664f", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ServiceError.fetchFailed
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw ServiceError.decodeFailed
        }
    }
}
