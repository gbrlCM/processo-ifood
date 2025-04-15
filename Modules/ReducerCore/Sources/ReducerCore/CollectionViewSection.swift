//
//  CollectionViewSection.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Foundation

public struct CollectionViewSection<SectionType: Hashable & Sendable, Item: Hashable & Sendable>:
    Hashable, Equatable, Sendable {
    public let sectionType: SectionType
    public let items: [Item]

    public init(sectionType: SectionType, items: [Item]) {
        self.sectionType = sectionType
        self.items = items
    }
}
