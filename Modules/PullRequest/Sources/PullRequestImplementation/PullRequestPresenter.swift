//
//  PullRequestPresenter.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Models
import ReducerCore

final class PullRequestPresenter: Presenter<State, ViewModel> {
    private typealias Section = CollectionViewSection<ViewModel.Section, ViewModel.Item>

    override func adapt(state: State) async -> ViewModel {
        var list: [Section] = []

        if let repository = state.repository {
            let repositorySection = adaptRepositoriesSection(repository: repository)
            list.append(repositorySection)

            let infoSection = adaptInfoSection(repository: repository)
            list.append(infoSection)
        }

        if !state.pullRequests.isEmpty {
            let pullRequestsSection = adaptPullRequestSection(prs: state.pullRequests)
            list.append(pullRequestsSection)
        }

        return ViewModel(list: list, isLoading: state.isLoading)
    }

    private func adaptRepositoriesSection(repository: GitHubRepository) -> Section {
        Section(
            sectionType: .repositories,
            items: [
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
    }

    private func adaptInfoSection(repository: GitHubRepository) -> Section {
        Section(
            sectionType: .info,
            items: [
                .info(
                    .init(imageName: "eye", value: "\(repository.watchersCount)")
                ),
                .info(
                    .init(imageName: "star", value: "\(repository.stargazersCount)")
                ),
                .info(
                    .init(imageName: "smallcircle.circle", value: "\(repository.openIssues ?? 0)")
                ),
                .info(
                    .init(imageName: "signpost.right.and.left", value: "\(repository.forks ?? 0)")
                ),
                .info(
                    .init(imageName: "person.3.sequence", value: "\(repository.subscribersCount ?? 0)")
                )
            ]
        )
    }

    private func adaptPullRequestSection(prs: [GitHubPullRequest]) -> Section {
        Section(
            sectionType: .pullRequests,
            items: prs.map {
                .pullRequest(
                    .init(
                        avatar: $0.user.avatarUrl,
                        title: $0.title,
                        status: $0.state.rawValue
                    )
                )
            }
        )
    }
}
