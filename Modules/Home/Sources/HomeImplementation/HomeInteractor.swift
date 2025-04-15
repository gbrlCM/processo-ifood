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
            if state.canLoadMoreItems {
                return await searchRepos(query: state.query, state: state)
            }
            return state
        case .loading(let value):
            var newState = state
            newState.isLoading = value
            return newState
        }
    }

    private func searchRepos(query: String, state: State) async -> State {
        var newState = state
        send(.loading(true))
        do {
            let repos = try await repository.fetchRepositories(for: query, at: state.page)
            newState.repositories += repos
            newState.query = query
            newState.page = state.page + 1
            newState.isLoading = false
            newState.canLoadMoreItems = true
        } catch {
            newState.isError = true
            newState.canLoadMoreItems = false
            newState.isLoading = false
        }

        return newState
    }
}
