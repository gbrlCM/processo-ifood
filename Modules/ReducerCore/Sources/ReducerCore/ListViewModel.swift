//
//  ListViewModel.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

public protocol ListViewModel: Equatable, Sendable {
    associatedtype Section: Hashable & Sendable
    associatedtype Item: Hashable & Sendable
    var list: [CollectionViewSection<Section, Item>] { get }
    var isLoading: Bool { get }
}
