//
//  StatefulViewController.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import Combine
import DesignSystem
import UIKit

open class StatefulViewController<Action, State: Equatable, ViewModel: Equatable>: LayoutableViewController {
    internal let reducer: Reducer<Action, State>
    internal let presenter: Presenter<State, ViewModel>
    internal var cancellables: Set<AnyCancellable>

    public init(reducer: Reducer<Action, State>, presenter: Presenter<State, ViewModel>) {
        self.reducer = reducer
        self.presenter = presenter
        self.cancellables = []
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }

    open override func setupStyle() {
        view.backgroundColor = UIColor(named: .background)
    }

    private func setupBindings() {
        presenter.bind(with: reducer.state.eraseToAnyPublisher())
        presenter.viewModel
            .subscribe(on: RunLoop.main)
            .sink {[weak self] viewModel in
                self?.configure(with: viewModel)
            }
            .store(in: &cancellables)
    }

    open func configure(with viewModel: ViewModel) {
        preconditionFailure("Abstract Method Overide it to use it")
    }

    public func execute(_ action: Action) {
        reducer.send(action)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
