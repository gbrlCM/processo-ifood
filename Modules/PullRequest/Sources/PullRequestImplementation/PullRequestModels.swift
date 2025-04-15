//
//  PullRequestModels.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import ReducerCore
import Models

enum Action {
    case initialLoad
    case loadMorePullRequests
    case tapPullRequestAt(index: Int)
    case loading(value: Bool)
    case tapRepository
    case shareRepo
    case sharePullRequestAt(index: Int)
}

struct State: Equatable {
    var repository: GitHubRepository?
    var pullRequests: [GitHubPullRequest] = []
    var isLoading: Bool = false
    var page: Int = 1
}

struct ViewModel: ListViewModel, Equatable {
    enum Item: Hashable, Equatable {}
    enum Section: Hashable, Equatable {}

    var list: [CollectionViewSection<Section, Item>]
    var isLoading: Bool
}
