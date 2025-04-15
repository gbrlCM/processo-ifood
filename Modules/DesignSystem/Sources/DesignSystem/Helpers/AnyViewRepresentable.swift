//
//  AnyViewRepresentable.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

#if DEBUG
import SwiftUI

public struct AnyViewRepresentable: UIViewRepresentable {
    let view: UIView

    public init(view: UIView) {
        self.view = view
    }

    public func makeUIView(context: Context) -> some UIView {
        view
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {}
}
#endif
