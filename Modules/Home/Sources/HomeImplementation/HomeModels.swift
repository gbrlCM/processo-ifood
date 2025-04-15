//
//  HomeModels.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import ReducerCore
import Models
import Foundation

enum Action {
    case search(query: String)
    case loadMore
    case loading(Bool)
}

struct State: Equatable {
    var query: String = ""
    var repositories: [GitHubRepository] = []
    var canLoadMoreItems: Bool = true
    var isLoading: Bool = false
    var isError: Bool = false
    var page: Int = 1
}

struct ViewModel: ListViewModel, Equatable {
    enum Section { case main }
    let list: [CollectionViewSection<Section, RepositoryViewModel>]
    let isLoading: Bool
}

struct RepositoryViewModel: Hashable, Sendable {
    let id: UInt64
    let avatarUrl: URL
    let title: String
    let subtitle: String
    let createdDate: String
    let license: String?
}
