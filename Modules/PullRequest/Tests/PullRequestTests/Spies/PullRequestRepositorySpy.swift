//
//  PullRequestRepositorySpy.swift
//  PullRequest
//
//  Created by Lua Ferreira de Carvalho on 20/04/25.
//
import Models
import Foundation
@testable import PullRequestImplementation

final actor PullRequestRepositorySpy: PullRequestRepositoryProtocol {
    private var repoReturn: GitHubRepository?
    private var prsReturn: [GitHubPullRequest]?

    enum Method: Equatable, Sendable {
        case githubRepo, pullRequests
    }

    private(set) var methods: [Method] = []

    func setRepoResponse(_ value: GitHubRepository?) {
        repoReturn = value
    }

    func githubRepo() async throws -> GitHubRepository {
        methods.append(.githubRepo)
        guard let repoReturn else { throw URLError(.badURL) }
        return repoReturn
    }

    func setPrsResponse(_ value: [GitHubPullRequest]?) {
        prsReturn = value
    }

    func pullRequests(page: Int) async throws -> [GitHubPullRequest] {
        methods.append(.pullRequests)
        guard let prsReturn else { throw URLError(.badURL) }
        return prsReturn
    }
}
