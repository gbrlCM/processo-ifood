//
//  PullRequestModels.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import ReducerCore
import Models
import Foundation

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
    var canLoadMore: Bool = true
    var page: Int = 1
}

struct ViewModel: ListViewModel, Equatable {
    enum Item: Hashable, Equatable {
        case repository(RepositoryViewModel)
        case info(InfoViewModel)
        case pullRequest(PullRequestViewModel)
    }
    enum Section: Hashable, Equatable {
        case repositories, info, pullRequests
    }

    var list: [CollectionViewSection<Section, Item>]
    var isLoading: Bool
}

struct RepositoryViewModel: Equatable, Hashable {
    let avatar: URL
    let title: String
    let owner: String
    let description: String
}

struct InfoViewModel: Equatable, Hashable {
    let imageName: String
    let value: String
}

struct PullRequestViewModel: Equatable, Hashable {
    let avatar: URL
    let title: String
    let status: String
}
