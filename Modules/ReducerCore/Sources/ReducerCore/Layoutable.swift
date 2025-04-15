//
//  Layoutable.swift
//  ReducerCore
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

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

import UIKit

open class LayoutableViewController: UIViewController, Layoutable {
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    open func setupHierarchy() {}
    open func setupLayout() {}
    open func setupStyle() {}
}
