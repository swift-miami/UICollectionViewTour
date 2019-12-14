import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {

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

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupCardStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Nope. ⛔️")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.shadowColor = UIColor.label.resolvedColor(with: traitCollection).cgColor
    }

    // MARK: - Helpers

    private func setupCardStyle() {
        contentView.layer.cornerCurve = .circular
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemBackground
        contentView.layer.masksToBounds = true

        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }

    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)

        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),

            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor,
                                                multiplier: 2),
            titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }

    // MARK: - Interface
    
    func configure(with title: String?, image: UIImage?) {

        titleLabel.text = title
        imageView.image = image
    }
}
