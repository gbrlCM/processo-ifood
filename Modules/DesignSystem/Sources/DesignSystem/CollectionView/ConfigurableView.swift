//
//  ConfigurableView.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import UIKit

open class ConfigurableView<ViewModel: Equatable & Hashable>: UIView, Layoutable {
    required public init() {
        super.init(frame: .zero)
        setupView()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func prepareForReuse() {}

    open func setupHierarchy() {}

    open func setupLayout() {}

    open func setupStyle() {}

    open func configure(with viewModel: ViewModel) {}
}
