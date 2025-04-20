//
//  PullRequestInteractorTests.swift
//  PullRequest
//
//  Created by Lua Ferreira de Carvalho on 20/04/25.
//
import Testing
import ReducerTestHelpers
import Models
import Foundation

@testable import PullRequestImplementation

@MainActor
@Suite("GIVEN a PullRequestInteractor")
struct PullRequestInteractorTests {
    let sut: PullRequestInteractor
    let tester: ReducerHelper<Action, State>
    let repositorySpy: PullRequestRepositorySpy
    let routerSpy: PullRequestRouterSpy

    init() {
        repositorySpy = PullRequestRepositorySpy()
        routerSpy = PullRequestRouterSpy()
        sut = PullRequestInteractor(
            repository: repositorySpy,
            router: routerSpy,
            initialState: State()
        )
        tester = ReducerHelper(reducer: sut)
    }

    @Test("WHEN tapRepository is tapped with a repo THEN it should call router")
    func testGoToWebView() async throws {
        let repo = try repo(name: "name")
        let state = State(repository: repo)

        let result = await sut.reduce(action: .tapRepository, for: state)

        #expect(result == state)
        #expect(routerSpy.methods == [.webView(path: "/path")])
    }

    @Test("WHEN tapShareRepository is tapped with a repo THEN it should call router")
    func testGoToShareRepo() async throws {
        let repo = try repo(name: "name")
        let state = State(repository: repo)

        let result = await sut.reduce(action: .shareRepo, for: state)

        #expect(result == state)
        #expect(
            routerSpy.methods == [.share(url: "https://www.example.com.br/path")]
        )
    }

    @Test("WHEN tapPullRequestAt is tapped with a pr THEN it should call router")
    func testGoToWebViewPR() async throws {
        let pr = try pr()
        let state = State(pullRequests: [pr])

        let result = await sut.reduce(action: .tapPullRequestAt(index: 0), for: state)

        #expect(result == state)
        #expect(routerSpy.methods == [.webView(path: "/path")])
    }

    @Test("WHEN sharePullRequestAt is tapped with a pr THEN it should call router")
    func testGoToSharePR() async throws {
        let pr = try pr()
        let state = State(pullRequests: [pr])

        let result = await sut.reduce(action: .sharePullRequestAt(index: 0), for: state)

        #expect(result == state)
        #expect(
            routerSpy.methods == [.share(url: "https://www.example.com.br/path")]
        )
    }

    @Test("WHEN initialLoading is called and succeed THEN it should request the repo and prs")
    func testInitialLoadSuccess() async throws {
        let repo = try repo(name: "repo")
        let prs = [try pr()]
        await repositorySpy.setPrsResponse(prs)
        await repositorySpy.setRepoResponse(repo)

        let result = await sut.reduce(action: .initialLoad, for: State())

        await tester.assertActions(equalTo: [.loading(value: true)])
        #expect(
            result == State(
                repository: repo,
                pullRequests: prs,
                isLoading: false,
                canLoadMore: true,
                page: 2
            )
        )
    }

    @Test("WHEN initialLoading is called and fails THEN it should show error")
    func testInitialLoadFailed() async throws {
        await repositorySpy.setPrsResponse(nil)
        await repositorySpy.setRepoResponse(nil)

        let result = await sut.reduce(action: .initialLoad, for: State())

        await tester.assertActions(equalTo: [.loading(value: true)])
        #expect(
            result == State(
                repository: nil,
                pullRequests: [],
                isLoading: false,
                canLoadMore: false,
                page: 1
            )
        )
        #expect(routerSpy.methods == [.error(message: "Ocorreu um error")])
    }

    @Test("WHEN loadMorePullRequests is called and succeed THEN it should load more prs")
    func testLoadMoreSuccess() async throws {
        let prs = [try pr()]
        await repositorySpy.setPrsResponse(prs)

        let result = await sut.reduce(
            action: .loadMorePullRequests,
            for: State(
                pullRequests: [try pr()],
                canLoadMore: true,
                page: 2
            )
        )

        await tester.assertActions(equalTo: [.loading(value: true)])
        #expect(
            result == State(
                repository: nil,
                pullRequests: prs + prs,
                isLoading: false,
                canLoadMore: true,
                page: 3
            )
        )
    }

    @Test("WHEN loadMorePullRequests is called and fails THEN it should show error")
    func testLoadMoreFailed() async throws {
        let prs = [try pr()]
        await repositorySpy.setPrsResponse(nil)

        let result = await sut.reduce(
            action: .loadMorePullRequests,
            for: State(
                pullRequests: prs,
                canLoadMore: true,
                page: 2
            )
        )

        await tester.assertActions(equalTo: [.loading(value: true)])
        #expect(
            result == State(
                repository: nil,
                pullRequests: prs,
                isLoading: false,
                canLoadMore: false,
                page: 2
            )
        )
        #expect(routerSpy.methods == [.error(message: "Ocorreu um error")])
    }

    @Test("WHEN loading is called THEN it should update the loading value")
    func testLoading() async throws {
        let state = State(isLoading: false)
        let result = await sut.reduce(action: .loading(value: true), for: state)
        #expect(result == State(isLoading: true))
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
