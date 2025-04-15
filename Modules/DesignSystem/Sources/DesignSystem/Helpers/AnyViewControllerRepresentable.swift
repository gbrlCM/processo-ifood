//
//  AnyViewControllerRepresentable.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
#if DEBUG
import SwiftUI

public struct AnyViewControllerRepresentable: UIViewControllerRepresentable {
    let viewController: UIViewController

    public init(viewController: UIViewController) {
        self.viewController = viewController
    }

    public func makeUIViewController(context: Context) -> some UIViewController {
        viewController
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
#endif
