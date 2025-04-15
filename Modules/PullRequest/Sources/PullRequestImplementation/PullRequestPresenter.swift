//
//  PullRequestPresenter.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//

import ReducerCore

final class PullRequestPresenter: Presenter<State, ViewModel> {
    override func adapt(state: State) async -> ViewModel {
        print(state.repository, state.pullRequests)
        return ViewModel(list: [], isLoading: state.isLoading)
    }
}
