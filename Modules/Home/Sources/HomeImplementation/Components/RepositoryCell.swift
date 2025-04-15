//
//  RepositoryCell.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import UIKit
import DesignSystem
import SnapKit
import DependencyInjection
import Network

final class RepositoryCell: ConfigurableCell<RepositoryView, RepositoryViewModel> {}

final class RepositoryView: ConfigurableView<RepositoryViewModel> {
    private let imageRepository: ImageRepositoryProtocol? =
    DependencyInjection.shared.resolve(for: ImageRepositoryProtocol.self)

    private let container = UIView()
    private let textContainer = UIStackView()
    private let avatar = DSAvatar()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let date = UILabel()

    override func setupHierarchy() {
        addSubview(container)
        container.addSubview(avatar)
        container.addSubview(textContainer)
        textContainer.addArrangedSubview(title)
        textContainer.addArrangedSubview(subtitle)
        textContainer.addArrangedSubview(date)
        textContainer.addArrangedSubview(UIView())
    }

    override func setupLayout() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.md)
            make.height.greaterThanOrEqualTo(64 + (Spacing.sm * 2))
        }

        avatar.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 64, height: 64))
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(Spacing.md)
        }

        textContainer.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(Spacing.sm)
            make.trailing.equalToSuperview().inset(Spacing.md)
            make.leading.equalTo(avatar.snp.trailing).offset(Spacing.md)
        }
    }

    override func setupStyle() {
        textContainer.axis = .vertical

        title.font = .preferredFont(forTextStyle: .headline)
        subtitle.font = .preferredFont(forTextStyle: .subheadline)
        date.font = .preferredFont(forTextStyle: .footnote)

        subtitle.numberOfLines = 3

        textContainer.spacing = Spacing.sm

        backgroundColor = UIColor(named: .cellBackground)
    }

    override func configure(with viewModel: RepositoryViewModel) {
        Task {
            let image = await imageRepository?.fetch(from: viewModel.avatarUrl)
            await MainActor.run {
                avatar.image = image
            }
        }

        title.text = viewModel.title
        subtitle.text = viewModel.subtitle
        date.text = viewModel.createdDate
    }

    override func prepareForReuse() {
        avatar.image = nil
    }
}
