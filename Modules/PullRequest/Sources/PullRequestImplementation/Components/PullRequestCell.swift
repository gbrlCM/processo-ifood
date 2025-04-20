//
//  PullRequestCell.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import UIKit
import SnapKit
import DesignSystem
import DependencyInjection
import Network

final class PullRequestCell: ConfigurableCell<PullRequestView, PullRequestViewModel> {}

final class PullRequestView: ConfigurableView<PullRequestViewModel> {
    private let avatar: DSAvatar = DSAvatar()
    private let title: UILabel = UILabel()
    private let status: UILabel = UILabel()
    private let share: UIButton = UIButton(type: .custom)
    private let navigate: UIButton = UIButton(type: .custom)
    private let buttonsStack: UIStackView = UIStackView()
    private let container: UIStackView = UIStackView()
    private let primaryContainer: UIView = UIStackView()

    private let imageRepository = DependencyInjection.shared.resolve(for: ImageRepositoryProtocol.self)

    var navigateButtonTapped: (() -> Void)?
    var shareButtonTapped: (() -> Void)?

    override func setupHierarchy() {
        addSubview(container)
        container.addArrangedSubviews(primaryContainer, buttonsStack, UIView())
        primaryContainer.addSubviews(avatar, title)
        buttonsStack.addArrangedSubviews(status, UIView(), share, navigate)
    }

    override func setupLayout() {
        title.setContentHuggingPriority(.defaultLow, for: .horizontal)

        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.md)
        }

        avatar.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 48, height: 48))
        }

        title.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
            make.leading.equalTo(avatar.snp.trailing).offset(Spacing.sm)
        }
    }

    override func setupStyle() {
        buttonsStack.axis = .horizontal
        container.axis = .vertical

        buttonsStack.spacing = Spacing.sm
        container.spacing = Spacing.sm
        title.font = .preferredFont(forTextStyle: .body)
        title.numberOfLines = 0

        share.configuration = .bordered()
        share.configuration?.baseForegroundColor = UIColor(named: .accent)
        share.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)

        navigate.configuration = .borderedTinted()
        navigate.configuration?.baseBackgroundColor = UIColor(named: .accent)
        navigate.configuration?.baseForegroundColor = UIColor(named: .accent)
        navigate.setTitle("Visitar", for: .normal)

        let shareAction = UIAction { [weak self] _ in
            guard let action = self?.shareButtonTapped else { return }
            action()
        }
        share.addAction(shareAction, for: .touchUpInside)

        let navigateAction = UIAction { [weak self] _ in
            guard let action = self?.navigateButtonTapped else { return }
            action()
        }
        navigate.addAction(navigateAction, for: .touchUpInside)
    }

    override func configure(with viewModel: PullRequestViewModel) {
        Task {
            let image = await imageRepository?.fetch(from: viewModel.avatar)
            await MainActor.run {
                avatar.image = image
            }
        }

        title.text = viewModel.title
        status.text = viewModel.status
    }

    override func prepareForReuse() {
        avatar.image = nil
        shareButtonTapped = nil
        navigateButtonTapped = nil
    }
}
