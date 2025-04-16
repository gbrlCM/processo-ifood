//
//  PullRequestPresenter.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//

import ReducerCore

final class PullRequestPresenter: Presenter<State, ViewModel> {
    override func adapt(state: State) async -> ViewModel {
        var list: [CollectionViewSection<ViewModel.Section, ViewModel.Item>] = []

        if let repository = state.repository {
            let repositorySection = CollectionViewSection(
                sectionType: ViewModel.Section.repositories,
                items: [
                    ViewModel.Item
                        .repository(
                            .init(
                                avatar: repository.owner.avatarUrl,
                                title: repository.name,
                                owner: repository.owner.login,
                                description: repository.description ?? ""
                            )
                        )
                ]
            )

            list.append(repositorySection)

            let infoSection = CollectionViewSection(
                sectionType: ViewModel.Section.info,
                items: [
                    ViewModel.Item.info(
                        .init(imageName: "eye", value: "\(repository.watchersCount)")
                    ),
                    ViewModel.Item.info(
                        .init(imageName: "star", value: "\(repository.stargazersCount)")
                    ),
                    ViewModel.Item.info(
                        .init(imageName: "smallcircle.circle", value: "\(repository.openIssues ?? 0)")
                    ),
                    ViewModel.Item.info(
                        .init(imageName: "signpost.right.and.left", value: "\(repository.forks ?? 0)")
                    ),
                    ViewModel.Item.info(
                        .init(imageName: "person.3.sequence", value: "\(repository.subscribersCount ?? 0)")
                    )
                ]
            )

            list.append(infoSection)
        }

        if !state.pullRequests.isEmpty {
            let pullRequestsSection = CollectionViewSection(
                sectionType: ViewModel.Section.pullRequests,
                items: state.pullRequests.map {
                    ViewModel.Item.pullRequest(
                        .init(avatar: $0.user.avatarUrl, title: $0.title, status: $0.state.rawValue)
                    )
                }
            )

            list.append(pullRequestsSection)
        }

        return ViewModel(list: list, isLoading: state.isLoading)
    }
}
