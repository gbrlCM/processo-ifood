//
//  HomePresenterTests.swift
//  Home
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//

import Testing
import Models
import Foundation

@testable import HomeImplementation

@MainActor
@Suite("GIVEN a HomePresenter")
struct HomePresenterTests {
    let sut = HomePresenter()

    @Test("WHEN adapt is called THEN it should create the viewModel")
    func testAdapt() async throws {
        let repo = GitHubRepository(
            id: 1,
            name: "name",
            owner: .init(
                login: "",
                id: 1,
                avatarUrl: try #require(URL(string: "https://example.com.br/path"))
            ),
            fullName: "fullName",
            description: nil,
            htmlUrl: try #require(URL(string: "https://example.com.br/path")),
            url: try #require(URL(string: "https://example.com.br/path")),
            createdAt: Date(timeIntervalSinceReferenceDate: 0),
            language: nil,
            stargazersCount: 10,
            watchersCount: 10,
            subscribersCount: 10,
            openIssues: 10,
            forks: 10,
            license: nil
        )

        let state = State(repositories: [repo], isLoading: false)

        let response = await sut.adapt(state: state)

        let expectedResponse = ViewModel(
            list: [
                .init(
                    sectionType: .main,
                    items: [
                        .init(
                            id: 1,
                            avatarUrl: try #require(URL(string: "https://example.com.br/path")),
                            title: "fullName",
                            subtitle: "",
                            createdDate: "31 de dez. de 2000",
                            license: nil
                        )
                    ]
                )
            ],
            isLoading: false
        )

        #expect(response == expectedResponse)
    }
}
