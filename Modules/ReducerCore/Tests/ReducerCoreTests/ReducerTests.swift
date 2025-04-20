//
//  ReducerTests.swift
//  ReducerCore
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//
import Testing
import ReducerTestHelpers

@testable import ReducerCore

@MainActor
@Suite("GIVEN a Reducer")
struct ReducerTests {
    let sut: TestReducer
    let tester: ReducerHelper<Int, String>

    init() {
        sut = TestReducer(initialState: "")
        tester = ReducerHelper(reducer: sut)
    }

    @Test("WHEN send is called THEN it should run the Reduce Flow")
    func testFlow() async throws {
        sut.send(1)
        sut.send(2)
        sut.send(3)

        await tester.assertActions(equalTo: [1, 2, 3])
    }
}
