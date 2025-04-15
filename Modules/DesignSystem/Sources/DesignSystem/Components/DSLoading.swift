//
//  DSLoading.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import SnapKit
import UIKit

public final class DSLoading: LayoutableView {
    private let progressIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private let background: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

    public override func setupHierarchy() {
        addSubview(background)
        addSubview(progressIndicator)
    }

    public override func setupLayout() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        progressIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.lg)
        }
    }

    public override func setupStyle() {
        progressIndicator.color = UIColor(named: .accent)
        background.backgroundColor = UIColor(named: .cellBackground).withAlphaComponent(0.3)
        background.layer.zPosition = -1
        background.layer.masksToBounds = true
        background.clipsToBounds = true
        background.layer.cornerRadius = CornerRadius.lg
        layer.cornerRadius = CornerRadius.lg
    }

    public func loading(_ isLoading: Bool) {
        if isLoading {
            progressIndicator.startAnimating()
        } else {
            progressIndicator.stopAnimating()
        }

        isHidden = !isLoading
    }
}
