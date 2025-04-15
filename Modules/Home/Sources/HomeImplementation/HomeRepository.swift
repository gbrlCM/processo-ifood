//
//  HomeRepository.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Models
import Network
import Foundation

protocol HomeRepositoryProtocol: Actor {
    func fetchRepositories(for query: String, at page: Int) async throws -> [GitHubRepository]
}

final actor HomeRepository: HomeRepositoryProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func fetchRepositories(for query: String, at page: Int) async throws -> [GitHubRepository] {
        let (data, _): (GitHubRepoResponse, URLResponse) = try await network
            .fetch(from: queryUrl(query: query, page: page)!)
        return data.items
    }

    private func queryUrl(query: String, page: Int) -> URL? {
        var components = URLComponents()
        components.path = "/search/repositories"
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        let builder = RouterBuilder(host: .api)
        return builder.build(for: components)
    }
}

struct GitHubRepoResponse: Decodable, Sendable {
    let items: [GitHubRepository]
}
