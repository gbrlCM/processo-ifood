//
//  HomeInteractorTests.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 17/04/25.
//
import Testing
import Models
import ReducerTestHelpers
import Foundation

@testable import ReducerCore
@testable import HomeImplementation

@MainActor
@Suite("GIVEN a HomeInteractor")
struct HomeInteractorTests {
    let sut: HomeInteractor
    let routerSpy: HomeRouterSpy
    let repositorySpy: HomeRepositorySpy
    let sutHelper: ReducerHelper<Action, State>

    init() {
        self.routerSpy = HomeRouterSpy()
        self.repositorySpy = HomeRepositorySpy()
        self.sut = HomeInteractor(
            repository: repositorySpy,
            router: routerSpy,
            initialState: State()
        )
        self.sutHelper = ReducerHelper(reducer: sut)
    }

    @Test("WHEN .loading is called THEN it should change loading value")
    func testLoading() async throws {
        let result = await sut.reduce(action: .loading(true), for: State())
        #expect(result.isLoading == true)
    }

    @Test("WHEN .search is called and it succeed THEN it should erase the page and request the repos")
    func testSearchSuccess() async throws {
        let originalRepo = try repo(name: "original")
        let newRepo = try repo(name: "new_repo")

        await repositorySpy.setFetchReponse([newRepo])

        let result = await sut.reduce(
            action: .search(query: "query"),
            for: State(repositories: [originalRepo], page: 10)
        )

        #expect(
            result == State(
                query: "query",
                repositories: [newRepo],
                canLoadMoreItems: true,
                isLoading: false,
                page: 2
            )
        )
    }

    @Test("WHEN .search is called and it failed THEN it should erase the page and call router")
    func testSearchFailure() async throws {
        let originalRepo = try repo(name: "original")

        await repositorySpy.setFetchReponse(nil)

        let result = await sut.reduce(
            action: .search(query: "query"),
            for: State(repositories: [originalRepo], page: 10)
        )

        #expect(
            result == State(
                query: "query",
                repositories: [],
                canLoadMoreItems: false,
                isLoading: false,
                isError: true,
                page: 1
            )
        )
        #expect(routerSpy.methods == [.error(message: L10n.Error.message)])
        await sutHelper.assertActions(equalTo: [.loading(true)])

        routerSpy.tryAgainClosure()
        await sutHelper.assertActions(equalTo: [.loading(true), .restart])
    }

    @Test("WHEN . restart is called THEN it should erase the state and try again")
    func testRestart() async throws {
        let old = try repo(name: "old")
        let repo = try repo(name: "restartRepo")
        await repositorySpy.setFetchReponse([repo])

        let result = await sut.reduce(action: .restart, for: State(query: "query", repositories: [old]))

        #expect(result == State(query: "query", repositories: [repo], page: 2))
    }

    @Test("WHEN .selectItemAt is called THEN it should call pullRequests")
    func testNavigatePullRequest() async throws {
        let repo = try repo(name: "repository")
        let state = State(repositories: [repo])

        let result = await sut.reduce(action: .selectItemAt(index: 0), for: state)

        #expect(result == state)
        #expect(routerSpy.methods == [.pullRequests(path: "/path")])
    }

    @Test("WHEN .loadMore is called with canLoadMore is false THEN it should just return the state")
    func testLoadMoreForbid() async throws {
        let result = await sut.reduce(action: .loadMore, for: State(canLoadMoreItems: false))

        #expect(result == State(canLoadMoreItems: false))
        #expect(routerSpy.methods.isEmpty)
    }

    @Test("WHEN .loadMore is called with canLoadMore is true THEN it should request more items")
    func testLoadMoreAllowed() async throws {
        let old = try repo(name: "old")
        let new = try repo(name: "new")
        await repositorySpy.setFetchReponse([new])

        let result = await sut.reduce(
            action: .loadMore,
            for: State(query: "query", repositories: [old], page: 2)
        )

        let expectedState = State(query: "query", repositories: [old, new], page: 3)

        #expect(result == expectedState)
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
