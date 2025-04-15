//
//  StatefulCollectionViewController.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import UIKit
import SnapKit
import DesignSystem

open class StatefulCollectionViewController<
    Action,
    State: Equatable,
    ViewModel: ListViewModel,
    Section: Hashable & Sendable, Item: Hashable & Sendable
>: StatefulViewController<Action, State, ViewModel>,
   UICollectionViewDelegate
where ViewModel.Item == Item, ViewModel.Section == Section {
    public private(set) lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        .init(collectionView: collectionView) {[weak self] collectionView, indexPath, item in
            guard let self else { return UICollectionViewCell() }
            return self.buildCell(for: collectionView, at: indexPath, with: item)
        }
    }()

    public private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    private let loadingView: DSLoading = DSLoading()

    open var layout: UICollectionViewLayout { UICollectionViewFlowLayout() }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        view.addSubview(loadingView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        loadingView.layer.zPosition = 1000

        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            return self?.buildSupplementaryView(for: collectionView, withKind: kind, at: indexPath)
        }

        setupCollectionViewBinding()
    }

    private func setupCollectionViewBinding() {
        presenter
            .viewModel
            .map(\.list)
            .removeDuplicates()
            .subscribe(on: RunLoop.main)
            .sink { [weak self] sections in
                self?.updateWithNewData(data: sections, animated: true)
            }
            .store(in: &cancellables)
    }

    open override func configure(with viewModel: ViewModel) {
        loading(with: viewModel)
    }

    open func loading(with viewModel: ViewModel) {
        loadingView.loading(viewModel.isLoading)
    }

    open override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(named: Colors.accent)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: Colors.text)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        UIBarButtonItem.appearance().tintColor = UIColor(named: Colors.text)
    }

    open func buildCell(
        for collectionView: UICollectionView,
        at indexPath: IndexPath,
        with item: Item
    ) -> UICollectionViewCell {
        fatalError("Abstract Method")
    }

    open func buildSupplementaryView(
        for collectionView: UICollectionView,
        withKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView? {
        return nil
    }

    open func didScrollToTheEnd() {}

    open func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let snapshot = dataSource.snapshot()
        if snapshot.numberOfItems > 0,
           (snapshot.numberOfItems - 1) == indexPath.row,
           (snapshot.numberOfSections - 1) == indexPath.section {
            didScrollToTheEnd()
        }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {}
}

extension StatefulCollectionViewController {
    public func updateWithNewData(data: [CollectionViewSection<Section, Item>], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(data.map(\.sectionType))
        data.forEach {
            snapshot.appendItems($0.items, toSection: $0.sectionType)
        }
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}
