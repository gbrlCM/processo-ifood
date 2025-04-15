//
//  PullRequestInteractor.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//

import ReducerCore

final class PullRequestInteractor: Reducer<Action, State> {
    private let repository: PullRequestRepositoryProtocol

    init(repository: PullRequestRepositoryProtocol, initialState: State) {
        self.repository = repository
        super.init(initialState: initialState)
    }

    override func reduce(action: Action, for state: State) async -> State {
        switch action {
        case .initialLoad:
            return await initialLoad(for: state)
        case .loadMorePullRequests:
            return state
        case .tapPullRequestAt(let index):
            return state
        case .tapRepository:
            return state
        case .shareRepo:
            return state
        case .sharePullRequestAt(let index):
            return state
        case let .loading(value):
            return loading(state: state, value: value)
        }
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
        } catch {
            newState.isLoading = false
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
            newState.isLoading = false
        } catch {
            newState.isLoading = false
        }
        return newState
    }

    private func loading(state: State, value: Bool) -> State {
        var newState = state
        newState.isLoading = value
        return newState
    }
}
