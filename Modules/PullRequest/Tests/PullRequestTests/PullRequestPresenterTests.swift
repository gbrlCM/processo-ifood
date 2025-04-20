//
//  PullRequestPresenterTests.swift
//  PullRequest
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//
import Models
import Testing
import ReducerCore
import Foundation

@testable import PullRequestImplementation

@MainActor
@Suite("GIVEN a PullRequestPresenter")
struct PullRequestPresenterTests {
    let sut: PullRequestPresenter

    init() {
        sut = PullRequestPresenter()
    }

    @Test("WHEN adapt is called with a repository THEN it should return a repository Section")
    func testRepositorySection() async throws {
        let repo = try repo()
        let state = State(repository: repo)

        let viewModel = await sut.adapt(state: state)

        let expectedSection = CollectionViewSection(
            sectionType: ViewModel.Section.repositories,
            items: [
                ViewModel.Item.repository(
                    RepositoryViewModel(
                        avatar: try #require(URL(string: "https://www.example.com.br/path")),
                        title: "repository",
                        owner: "owner",
                        description: "Description"
                    )
                )
            ]
        )

        #expect(viewModel.list[0] == expectedSection)
    }

    @Test("WHEN adapt is called with a repository THEN it should return a info Section")
    func testInfoSection() async throws {
        let repo = try repo()
        let state = State(repository: repo)

        let viewModel = await sut.adapt(state: state)

        let expectedSection = CollectionViewSection<ViewModel.Section, ViewModel.Item>(
            sectionType: .info,
            items: [
                .info(
                    .init(imageName: "eye", value: "10")
                ),
                .info(
                    .init(imageName: "star", value: "10")
                ),
                .info(
                    .init(imageName: "smallcircle.circle", value: "10")
                ),
                .info(
                    .init(imageName: "signpost.right.and.left", value: "10")
                ),
                .info(
                    .init(imageName: "person.3.sequence", value: "10")
                )
            ]
        )

        #expect(viewModel.list[1] == expectedSection)
    }

    @Test("WHEN adapt is called with PRs THEN it should return a pull request Section")
    func testPrSection() async throws {
        let pr = try pr()
        let state = State(pullRequests: [pr])

        let viewModel = await sut.adapt(state: state)

        let expectedSection = CollectionViewSection<ViewModel.Section, ViewModel.Item>(
            sectionType: .pullRequests,
            items: [
                .pullRequest(
                    .init(
                        avatar: try #require(URL(string: "https://www.example.com.br/path")),
                        title: "Title",
                        status: "closed"
                    )
                )
            ]
        )

        #expect(viewModel.list[0] == expectedSection)
    }

    private func repo() throws -> GitHubRepository {
        let url = try #require(URL(string: "https://www.example.com.br/path"))
        return GitHubRepository(
            id: 1,
            name: "repository",
            owner: .init(login: "owner", id: 1, avatarUrl: url),
            fullName: "owner/repository",
            description: "Description",
            htmlUrl: url,
            url: url,
            createdAt: Date(timeIntervalSinceReferenceDate: 0),
            language: nil,
            stargazersCount: 10,
            watchersCount: 10,
            subscribersCount: 10,
            openIssues: 10,
            forks: 10,
            license: nil
        )
    }

    private func pr() throws -> GitHubPullRequest {
        let url = try #require(URL(string: "https://www.example.com.br/path"))
        return GitHubPullRequest(
            nodeId: "nodeId",
            htmlUrl: url,
            number: 1,
            state: .closed,
            title: "Title",
            body: "Body",
            user: .init(login: "owner", id: 1, avatarUrl: url),
            createdAt: Date(timeIntervalSinceReferenceDate: 0),
            updatedAt: nil,
            closedAt: nil,
            mergedAt: nil
        )
    }
}
