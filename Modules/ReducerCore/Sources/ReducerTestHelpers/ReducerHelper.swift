//
//  ReducerHelper.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 17/04/25.
//

@testable import ReducerCore
import Combine
import Testing

@MainActor
public final class ReducerHelper<Action: Equatable & Sendable, State: Equatable & Sendable> {
    private let reducer: Reducer<Action, State>

    public let states: CurrentValueSubject<[State], Never> = .init([])
    public let actions: CurrentValueSubject<[Action], Never> = .init([])
    private var cancellables = Set<AnyCancellable>()

    public init(reducer: Reducer<Action, State>) {
        self.reducer = reducer

        reducer
            .state
            .scan([]) { partial, value in partial + [value] }
            .subscribe(states)
            .store(in: &cancellables)


        reducer
            .actionSubject
            .scan([]) { partial, value in partial + [value] }
            .subscribe(actions)
            .store(in: &cancellables)
    }

    public func assertStates(equalTo result: [State]) async {
        await confirmation(
            "Could not find any State emition sequence equal to \(result)",
            expectedCount: result.count
        ) { confirmation in
            states.sink { states in
                if result == states {
                    confirmation()
                }
            }.store(in: &cancellables)
        }
    }

    public func assertActions(equalTo result: [Action]) async {
        await confirmation(
            "Could not find any Action emition sequence equal to \(result)",
            expectedCount: 1
        ) { confirmation in
            actions.sink { actions in
                if result == actions {
                    confirmation()
                }
            }.store(in: &cancellables)
        }
    }
}
