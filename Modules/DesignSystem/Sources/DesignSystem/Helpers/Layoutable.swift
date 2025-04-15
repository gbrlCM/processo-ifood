//
//  Layoutable.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import UIKit

@MainActor
public protocol Layoutable {
    func setupHierarchy()
    func setupLayout()
    func setupStyle()
}

extension Layoutable {
    public func setupHierarchy() {}
    public func setupLayout() {}
    public func setupStyle() {}
    public func setupView() {
        setupHierarchy()
        setupLayout()
        setupStyle()
    }
}
