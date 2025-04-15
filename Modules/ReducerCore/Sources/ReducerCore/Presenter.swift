//
//  Presenter.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Combine
import Foundation

@MainActor
open class Presenter<State: Equatable, ViewModel: Equatable> {
    internal let viewModel: PassthroughSubject<ViewModel, Never>
    private var cancellables: Set<AnyCancellable>

    public init() {
        self.viewModel = PassthroughSubject()
        self.cancellables = []
    }

    func bind(with state: AnyPublisher<State, Never>) {
        state
            .removeDuplicates()
            .flatMap { state in
                return Future { [weak self] completion in
                    Task {
                        let viewModel = await self?.adapt(state: state)
                        completion(.success(viewModel))
                    }
                }
            }
            .compactMap { $0 }
            .removeDuplicates()
            .subscribe(on: RunLoop.main)
            .subscribe(viewModel)
            .store(in: &cancellables)
    }

    open func adapt(state: State) async -> ViewModel {
        preconditionFailure("Abstract method override it to use it")
    }
}
