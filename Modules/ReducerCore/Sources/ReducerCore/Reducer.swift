//
//  Reducer.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Foundation
import Combine

@MainActor
open class Reducer<Action, State: Equatable> {
    internal let state: CurrentValueSubject<State, Never>
    internal let actionSubject: PassthroughSubject<Action, Never>
    internal var cancellables: Set<AnyCancellable>

    public init(initialState: State) {
        self.actionSubject = PassthroughSubject()
        self.state = CurrentValueSubject(initialState)
        self.cancellables = []
        setupBindings()
    }

    private func setupBindings() {
        actionSubject
            .subscribe(on: RunLoop.main)
            .compactMap { [weak self] action -> (Action, State)? in
                guard let self else { return nil }
                return (action, self.state.value)
            }
            .flatMap { (action, state) in
                return Future { [weak self] completion in
                    guard let self else {
                        completion(.success(state))
                        return
                    }
                    Task {
                        let newState = await self.reduce(action: action, for: state)
                        completion(.success(newState))
                    }
                }
            }
            .subscribe(state)
            .store(in: &cancellables)
    }

    public func send(_ action: Action) {
        actionSubject.send(action)
    }

    open func reduce(action: Action, for state: State) async -> State {
        preconditionFailure("Abstract Method Overide it to use it")
    }
}
