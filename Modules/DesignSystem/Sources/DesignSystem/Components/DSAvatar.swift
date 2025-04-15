//
//  DSAvatar.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import UIKit
import SnapKit

public final class DSAvatar: LayoutableView {
    private let imageView = UIImageView()

    public var image: UIImage? {
        get {
            imageView.image
        }

        set {
            imageView.image = newValue
        }
    }

    public override func setupHierarchy() {
        addSubview(imageView)
    }

    public override func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    public override func setupStyle() {
        imageView.contentMode = .scaleAspectFill
        layer.masksToBounds = true
        backgroundColor = .white
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.width / 2
    }
}
