//
//  PullRequestViewController.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//

import UIKit
import DesignSystem
import ReducerCore

typealias PullRequestViewControllerType = StatefulCollectionViewController<
    Action,
    State,
    ViewModel,
    ViewModel.Section,
    ViewModel.Item
>

final class PullRequestViewController: PullRequestViewControllerType {
    private let pullRequestCellRegistration = PullRequestCell.cellRegistration
    private let repositoryCellRegistration = RepositoryCell.cellRegistration
    private let infoCellRegistration = InfoCell.cellRegistration

    override var layout: UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let section = self?.dataSource.sectionIdentifier(for: sectionIndex) else {
                return .list(using: .init(appearance: .plain), layoutEnvironment: environment)
            }

            switch section {
            case .repositories,
                    .pullRequests:
                return .list(using: .init(appearance: .plain), layoutEnvironment: environment)
            case .info:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(72),
                    heightDimension: .estimated(72)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = Spacing.md
                section.contentInsets = .init(
                    top: Spacing.md,
                    leading: Spacing.md,
                    bottom: Spacing.md,
                    trailing: Spacing.md
                )
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
        }
        return layout
    }

    override func setupStyle() {
        super.setupStyle()

        let action = UIAction {[weak self] _ in
            self?.execute(.shareRepo)
        }
        let item = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), primaryAction: action)
        navigationItem.rightBarButtonItem = item
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        execute(.initialLoad)
    }

    override func buildCell(
        for collectionView: UICollectionView,
        at indexPath: IndexPath,
        with item: ViewModel.Item
    ) -> UICollectionViewCell {
        switch item {
        case .repository(let repositoryViewModel):
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: repositoryCellRegistration,
                for: indexPath,
                item: repositoryViewModel
            )

            cell.content.navigateButtonTapped = { [weak self] in
                self?.execute(.tapRepository)
            }

            return cell
        case .info(let infoViewModel):
            return collectionView.dequeueConfiguredReusableCell(
                using: infoCellRegistration,
                for: indexPath,
                item: infoViewModel
            )
        case .pullRequest(let pullRequestViewModel):
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: pullRequestCellRegistration,
                for: indexPath,
                item: pullRequestViewModel
            )

            cell.content.navigateButtonTapped = { [weak self] in
                self?.execute(.tapPullRequestAt(index: indexPath.row))
            }

            cell.content.shareButtonTapped = { [weak self] in
                self?.execute(.sharePullRequestAt(index: indexPath.row))
            }

            return cell
        }
    }

    override func didScrollToTheEnd() {
        execute(.loadMorePullRequests)
    }
}
