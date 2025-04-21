//
//  PullRequestInteractor.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Foundation
import ReducerCore

final class PullRequestInteractor: Reducer<Action, State> {
    private let repository: PullRequestRepositoryProtocol
    private let router: PullRequestRouterProtocol

    init(
        repository: PullRequestRepositoryProtocol,
        router: PullRequestRouterProtocol,
        initialState: State
    ) {
        self.repository = repository
        self.router = router
        super.init(initialState: initialState)
    }

    override func reduce(action: Action, for state: State) async -> State {
        switch action {
        case .initialLoad:
            return await initialLoad(for: State())
        case .loadMorePullRequests:
            if state.canLoadMore {
                return await loadMoreItems(for: state)
            }
        case .tapPullRequestAt(let index):
            goToWebView(at: state.pullRequests[safe: index]?.htmlUrl.relativePath)
        case .tapRepository:
            goToWebView(at: state.repository?.htmlUrl.relativePath)
        case .shareRepo:
            share(url: state.repository?.htmlUrl)
        case .sharePullRequestAt(let index):
            share(url: state.pullRequests[safe: index]?.htmlUrl)
        case let .loading(value):
            return loading(state: state, value: value)
        }
        return state
    }

    private func initialLoad(for state: State) async -> State {
        var newState = state
        send(.loading(value: true))
        do {
            let repo = try await repository.githubRepo()
            let pullRequests = try await repository.pullRequests(page: state.page)
            newState.page += 1
            newState.repository = repo
            newState.pullRequests = pullRequests
            newState.isLoading = false
            newState.canLoadMore = !pullRequests.isEmpty
        } catch {
            newState.isLoading = false
            newState.canLoadMore = false
            router.error(message: "Ocorreu um error") { [weak self] in
                self?.send(.initialLoad)
            }
        }

        return newState
    }

    private func loadMoreItems(for state: State) async -> State {
        var newState = state
        send(.loading(value: true))
        do {
            let pullRequests = try await repository.pullRequests(page: state.page)
            newState.page += 1
            newState.pullRequests += pullRequests
            newState.canLoadMore = !pullRequests.isEmpty
            newState.isLoading = false
        } catch {
            newState.isLoading = false
            newState.canLoadMore = false
            router.error(message: L10n.Error.message) { [weak self] in
                self?.send(.initialLoad)
            }

        }
        return newState
    }

    private func loading(state: State, value: Bool) -> State {
        var newState = state
        newState.isLoading = value
        return newState
    }

    private func goToWebView(at path: String?) {
        if let path {
            router.webView(for: path)
        }
    }

    private func share(url: URL?) {
        if let url {
            router.share(for: url)
        }
    }
}
