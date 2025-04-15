//
//  Array+Safe.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
