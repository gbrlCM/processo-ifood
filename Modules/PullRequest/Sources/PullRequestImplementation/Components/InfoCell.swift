//
//  InfoCell.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import UIKit
import SnapKit
import DesignSystem

final class InfoCell: ConfigurableCell<InfoView, InfoViewModel> {}

final class InfoView: ConfigurableView<InfoViewModel> {
    private let icon: UIImageView = UIImageView()
    private let value: UILabel = UILabel()

    override func setupHierarchy() {
        addSubviews(icon, value)
    }

    override func setupLayout() {
        icon.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(Spacing.sm)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        value.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(Spacing.sm)
            make.top.equalTo(icon.snp.bottom).offset(Spacing.xSm)
        }

        value.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
    }

    override func setupStyle() {
        icon.contentMode = .scaleAspectFit
        value.font = .preferredFont(forTextStyle: .subheadline)
        value.textAlignment = .center
        value.numberOfLines = 1
        backgroundColor = UIColor(named: .cellBackground)
        layer.cornerRadius = CornerRadius.md
    }

    override func configure(with viewModel: InfoViewModel) {
        value.text = viewModel.value
        icon.image = UIImage(systemName: viewModel.imageName)
        icon.tintColor = UIColor(named: .accent)
    }

    override func prepareForReuse() {
        icon.image = nil
    }
}
