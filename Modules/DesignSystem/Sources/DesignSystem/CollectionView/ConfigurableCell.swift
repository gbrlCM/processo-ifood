//
//  ConfigurableCell.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import UIKit
import SnapKit

open class ConfigurableCell<Content: ConfigurableView<ViewModel>,
                                ViewModel: Equatable & Hashable>: UICollectionViewCell {
    let content: Content

    override public init(frame: CGRect) {
        self.content = Content()
        super.init(frame: frame)
        contentView.addSubview(content)

        content.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with viewModel: ViewModel) {
        content.configure(with: viewModel)
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        content.prepareForReuse()
    }

    static public var cellRegistration: UICollectionView.CellRegistration<ConfigurableCell, ViewModel> {
        UICollectionView.CellRegistration<ConfigurableCell, ViewModel> { cell, _, itemIdentifier in
            cell.configure(with: itemIdentifier)
        }
    }
}
