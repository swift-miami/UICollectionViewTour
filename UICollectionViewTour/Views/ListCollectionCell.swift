import UIKit

final class ListCollectionCell: UICollectionViewCell {

    // MARK: - Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        return separator
    }()

    private let disclosureView: UIImageView = {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        let discloureIcon = UIImage(systemName: "chevron.right",
                                    withConfiguration: config)
        let imageView = UIImageView(image: discloureIcon)
        imageView.tintColor = .separator
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()


    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Nope. ⛔️")
    }

    // MARK: - Helpers

    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(disclosureView)
        contentView.addSubview(separator)

        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: guide.leadingAnchor,
                                               multiplier: 2),

            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor,
                                                multiplier: 2),
            titleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: disclosureView.trailingAnchor,
                                                 multiplier: 2),

            disclosureView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            disclosureView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            separator.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: UIView.onePixel),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Interface

    func configure(with title: String?,
                   image: UIImage?,
                   tintColor: UIColor? = .label) {

        titleLabel.text = title
        titleLabel.textColor = tintColor
        imageView.image = image
        imageView.tintColor = tintColor
    }
}
