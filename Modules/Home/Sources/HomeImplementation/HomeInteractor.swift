//
//  HomeInteractor.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Models
import Foundation
import ReducerCore

final class HomeInteractor: Reducer<Action, State> {
    private let repository: HomeRepositoryProtocol
    private let router: HomeRouterProtocol

    init(repository: HomeRepositoryProtocol, router: HomeRouterProtocol, initialState: State) {
        self.repository = repository
        self.router = router
        super.init(initialState: initialState)
    }

    override func reduce(action: Action, for state: State) async -> State {
        switch action {
        case .search(let query):
            return await searchRepos(query: query, state: state)
        case .loadMore:
            return await loadMore(state: state)
        case .loading(let value):
            return loading(state: state, value: value)
        case .selectItemAt(index: let index):
            navigateToPullRequest(state: state, index: index)
            return state
        case .restart:
            return await restart(state: state)
        }
    }

    private func searchRepos(query: String, state: State) async -> State {
        var newState = state
        send(.loading(true))
        newState.query = query
        do {
            let repos = try await repository.fetchRepositories(for: query, at: state.page)
            newState.repositories += repos
            newState.page = state.page + 1
            newState.isLoading = false
            newState.canLoadMoreItems = true
        } catch {
            newState.isError = true
            newState.canLoadMoreItems = false
            newState.isLoading = false
            router.error(message: L10n.Error.message, tryAgain: { [weak self] in
                self?.send(.restart)
            })
        }

        return newState
    }

    private func loadMore(state: State) async -> State {
        if state.canLoadMoreItems {
            return await searchRepos(query: state.query, state: state)
        }
        return state
    }

    private func restart(state: State) async -> State {
        let newState = State(query: state.query)
        return await searchRepos(query: newState.query, state: newState)
    }

    private func loading(state: State, value: Bool) -> State {
        var newState = state
        newState.isLoading = value
        return newState
    }

    private func navigateToPullRequest(state: State, index: Int) {
        guard
            let repo = state.repositories[safe: index],
            let url = URLComponents(url: repo.url, resolvingAgainstBaseURL: false)
        else { return }

        router.pullRequests(path: url.path)
    }
}
