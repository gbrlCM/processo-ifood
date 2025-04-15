//
//  HomeViewController.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import UIKit
import ReducerCore
import Combine

final class HomeViewController: StatefulCollectionViewController<
Action,
State, ViewModel,
ViewModel.Section,
ViewModel.Item
> {
    private let searchController: UISearchController = UISearchController()
    private var cancellables: Set<AnyCancellable> = []
    private let searchSubject: CurrentValueSubject<String, Never> = .init("")

    override var layout: UICollectionViewLayout {
        return UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
    }

    let cellRegistration = RepositoryCell.cellRegistration

    override func buildCell(
        for collectionView: UICollectionView,
        at indexPath: IndexPath,
        with item: RepositoryViewModel
    ) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: item
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        searchController.searchBar.text = searchSubject.value
        searchController.searchResultsUpdater = self
        navigationItem.title = "Repositories"
        setupBindings()
    }

    private func setupBindings() {
        searchSubject
            .filter { !$0.isEmpty }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .sink {[weak self] value in
                self?.execute(.search(query: value))
            }
            .store(in: &cancellables)
    }

    override func didScrollToTheEnd() {
        execute(.loadMore)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchSubject.send(searchController.searchBar.text ?? "")
    }
}
