//
//  DSError.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import UIKit
import SnapKit

public final class DSError: LayoutableView {
    private let container = UIStackView()
    private let message = UILabel()
    private let button = UIButton(type: .system)

    public override func setupHierarchy() {
        addSubview(container)
        container.addArrangedSubviews(message, button, UIView())
    }

    public override func setupLayout() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.md)
        }
    }

    public override func setupStyle() {
        container.axis = .vertical
        container.spacing = Spacing.lg
        message.textAlignment = .center
        message.font = .preferredFont(forTextStyle: .body)
        button.configuration = .borderedTinted()
        button.configuration?.baseBackgroundColor = UIColor(named: .accent)
        button.configuration?.baseForegroundColor = UIColor(named: .accent)
        backgroundColor = UIColor(named: .cellBackground)
    }

    public func configure(
        message: String,
        buttonTitle: String,
        onTap: @escaping () -> Void
    ) {
        self.message.text = message
        self.button.setTitle(buttonTitle, for: .normal)
        self.button.addAction(UIAction(handler: { _ in onTap() }), for: .touchUpInside)
    }
}
