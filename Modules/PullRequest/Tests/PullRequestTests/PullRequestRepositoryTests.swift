//
//  PullRequestRepositoryTests.swift
//  PullRequest
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//

import Network
import NetworkTestHelpers
import Models
import Testing
import Foundation

@testable import PullRequestImplementation

@Suite("GIVEN a PullRequestRepository")
struct PullRequestRepositoryTests {
    let sut: PullRequestRepository
    let network: NetworkSpy

    init() {
        network = NetworkSpy()
        sut = PullRequestRepository(initialPath: "/initialpath", network: network)
    }

    @Test("WHEN githubRepo is called THEN it should return the repo")
    func testRepo() async throws {
        await network.registerResponse(
            key: try #require(
                URL(string: "https://api.github.com/initialpath")
            ),
            try repo(name: "repo")
        )

        let result = try await sut.githubRepo()
        let expectedResult = try repo(name: "repo")
        #expect(result == expectedResult)
    }

    @Test("WHEN pullRequest is called THEN it should return the PRs")
    func testPrs() async throws {
        await network.registerResponse(
            key: try #require(
                URL(string: "https://api.github.com/initialpath/pulls?page=1")
            ),
            [try pr(name: "example")]
        )

        let result = try await sut.pullRequests(page: 1)
        let expectedResult = [try pr(name: "example")]
        #expect(result == expectedResult)
    }

    private func repo(name: String) throws -> GitHubRepository {
        let url = try #require(URL(string: "https://www.example.com.br/path"))
        return GitHubRepository(
            id: 9,
            name: name,
            owner: .init(login: "", id: 0, avatarUrl: url),
            fullName: "",
            description: nil,
            htmlUrl: url,
            url: url,
            createdAt: Date(timeIntervalSinceReferenceDate: 0),
            language: nil,
            stargazersCount: 1,
            watchersCount: 1,
            subscribersCount: 1,
            openIssues: 1,
            forks: 1,
            license: nil
        )
    }

    private func pr(name: String) throws -> GitHubPullRequest {
        let url = try #require(URL(string: "https://www.example.com.br/path"))
        return GitHubPullRequest(
            nodeId: "",
            htmlUrl: url,
            number: 1,
            state: .closed,
            title: name,
            body: nil,
            user: .init(login: "", id: 1, avatarUrl: url),
            createdAt: Date(timeIntervalSinceReferenceDate: 0),
            updatedAt: nil,
            closedAt: nil,
            mergedAt: nil
        )
    }
}
