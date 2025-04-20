//
//  TestReducer.swift
//  ReducerCore
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//

import ReducerCore

final class TestReducer: Reducer<Int, String> {
    override func reduce(action: Int, for state: String) async -> String {
        state + "\(action)"
    }
}
