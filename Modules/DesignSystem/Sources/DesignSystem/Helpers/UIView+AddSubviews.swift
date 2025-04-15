//
//  UIView+AddSubviews.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import UIKit

extension UIView {
    public func addSubviews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
}

extension UIStackView {
    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
