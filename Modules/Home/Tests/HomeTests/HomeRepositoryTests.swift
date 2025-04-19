//
//  HomeRepositoryTests.swift
//  Home
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//

import Network
import NetworkTestHelpers
import Models
import Testing
import Foundation

@testable import HomeImplementation

@Suite("GIVEN a HomeRepository")
struct HomeRepositoryTests {
    let sut: HomeRepository
    let network: NetworkSpy

    init() {
        network = NetworkSpy()
        sut = HomeRepository(network: network)
    }

    @Test("WHEN fetchRepositories is called THEN it should return the repos")
    func testFetch() async throws {
        await network.registerResponse(
            key: try #require(
                URL(string: "https://api.github.com/search/repositories?q=query&page=3")
            ),
            GitHubRepoResponse(items: [try repo(name: "repo")])
        )

        let result = try await sut.fetchRepositories(for: "query", at: 3)
        let expectedResult = [try repo(name: "repo")]
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
}
