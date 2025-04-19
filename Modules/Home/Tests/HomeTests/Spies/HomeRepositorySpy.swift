//
//  HomeRepositorySpy.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 17/04/25.
//
import Models
import Foundation
@testable import HomeImplementation

final actor HomeRepositorySpy: HomeRepositoryProtocol {
    enum Method: Equatable {
        case fetchRepositories(for: String, at: Int)
    }

    private(set) var methods: [Method] = []

    var fetchResponse: [GitHubRepository]?
    func fetchRepositories(for query: String, at page: Int) async throws -> [GitHubRepository] {
        methods.append(.fetchRepositories(for: query, at: page))

        guard let fetchResponse else { throw NSError() }
        return fetchResponse
    }

    func setFetchReponse(_ response: [GitHubRepository]?) {
        fetchResponse = response
    }
}
