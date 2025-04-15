//
//  HomePresenter.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import ReducerCore
import Foundation

final class HomePresenter: Presenter<State, ViewModel> {
    override func adapt(state: State) async -> ViewModel {
        let dateFormarter = DateFormatter()

        dateFormarter.dateStyle = .medium

        let items = state.repositories.map { repo in
            return RepositoryViewModel(
                id: repo.id,
                avatarUrl: repo.owner.avatarUrl,
                title: repo.fullName,
                subtitle: repo.description ?? "",
                createdDate: dateFormarter.string(from: repo.createdAt),
                license: repo.license?.name
            )
        }
        return ViewModel(list: [CollectionViewSection(sectionType: .main, items: items)], isLoading: state.isLoading)
    }
}
