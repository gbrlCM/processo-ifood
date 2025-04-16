//
//  RepositoryCell.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import UIKit
import SnapKit
import DesignSystem
import Network
import DependencyInjection

final class RepositoryCell: ConfigurableCell<RepositoryView, RepositoryViewModel> {}

final class RepositoryView: ConfigurableView<RepositoryViewModel> {
    private let avatar: DSAvatar = DSAvatar()
    private let title: UILabel = UILabel()
    private let author: UILabel = UILabel()
    private let subtitle: UILabel = UILabel()
    private let button: UIButton = UIButton(type: .system)
    private let container: UIStackView = UIStackView()

    var navigateButtonTapped: (() -> Void)? = nil

    private let imageRepository = DependencyInjection.shared.resolve(for: ImageRepositoryProtocol.self)

    override func setupHierarchy() {
        addSubview(container)
        container.addArrangedSubviews(
            avatar,
            title,
            author,
            subtitle,
            button,
            UIView()
        )
    }

    override func setupLayout() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.md)
        }

        avatar.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 72, height: 72))
        }
    }

    override func setupStyle() {
        container.axis = .vertical
        container.alignment = .center
        title.font = .preferredFont(forTextStyle: .title2, compatibleWith: .init(legibilityWeight: .bold))
        author.font = .preferredFont(forTextStyle: .subheadline)
        subtitle.font = .preferredFont(forTextStyle: .footnote)
        button.configuration = .borderedTinted()
        button.configuration?.baseBackgroundColor = UIColor(named: .accent)
        button.configuration?.baseForegroundColor = UIColor(named: .accent)
        button.setTitle("Visitar", for: .normal)

        container.setCustomSpacing(Spacing.sm, after: avatar)
        container.setCustomSpacing(Spacing.xSm, after: title)
        container.setCustomSpacing(Spacing.md, after: author)
        container.setCustomSpacing(Spacing.md, after: subtitle)

        title.numberOfLines = 1
        author.numberOfLines = 1
        subtitle.numberOfLines = 0

        let buttonAction = UIAction { [weak self] _ in
            guard let action = self?.navigateButtonTapped else { return }
            action()
        }
        button.addAction(buttonAction, for: .touchUpInside)
    }

    override func configure(with viewModel: RepositoryViewModel) {
        Task {
            let image = await imageRepository?.fetch(from: viewModel.avatar)
            await MainActor.run {
                avatar.image = image
            }
        }

        title.text = viewModel.title
        author.text = viewModel.owner
        subtitle.text = viewModel.description
    }

    override func prepareForReuse() {
        avatar.image = nil
        navigateButtonTapped = nil
    }
}
