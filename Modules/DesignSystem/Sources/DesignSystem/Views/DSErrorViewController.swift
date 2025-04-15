//
//  DSErrorViewController.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import UIKit

public final class DSErrorViewController: LayoutableViewController {
    private let contentView: DSError = DSError()

    public override func setupHierarchy() {
        view.addSubview(contentView)
    }

    public override func setupLayout() {
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }

    public override func setupStyle() {
        view.backgroundColor = UIColor(named: .cellBackground)
    }

    public func configure(
        title: String,
        message: String,
        buttonTitle: String,
        onTap: @escaping () -> Void
    ) {
        navigationItem.title = title
        contentView.configure(message: message, buttonTitle: buttonTitle, onTap: onTap)
    }
}
