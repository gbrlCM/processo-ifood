//
//  PullRequestRepository.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Network
import Foundation
import Models

protocol PullRequestRepositoryProtocol: Actor {
    func githubRepo() async throws -> GitHubRepository
    func pullRequests(page: Int) async throws -> [GitHubPullRequest]
}

final actor PullRequestRepository: PullRequestRepositoryProtocol {
    private let initialPath: String
    private let network: NetworkProtocol

    init(initialPath: String, network: NetworkProtocol) {
        self.initialPath = initialPath
        self.network = network
    }

    func githubRepo() async throws -> GitHubRepository {
        guard let url = repoRequestUrl() else { throw URLError(.badURL) }
        let (repo, _): (GitHubRepository, URLResponse) = try await network.fetch(from: url)
        return repo
    }

    func pullRequests(page: Int) async throws -> [GitHubPullRequest] {
        guard let url = pullRequestsUrl(page: page) else { throw URLError(.badURL) }
        let (data, _): ([GitHubPullRequest], URLResponse) = try await network.fetch(from: url)
        return data
    }

    private func repoRequestUrl() -> URL? {
        var components = URLComponents()
        components.path = initialPath

        return RouterBuilder(host: .api).build(for: components)
    }

    private func pullRequestsUrl(page: Int) -> URL? {
        var components = URLComponents()
        components.path = "\(initialPath)/pulls"
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]

        return RouterBuilder(host: .api).build(for: components)
    }
}
