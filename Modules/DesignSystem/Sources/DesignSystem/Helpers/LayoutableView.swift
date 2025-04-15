//
//  LayoutableView.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import UIKit

open class LayoutableView: UIView, Layoutable {
    public init() {
        super.init(frame: .zero)
        setupView()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setupHierarchy() {}

    open func setupLayout() {}

    open func setupStyle() {}
}
