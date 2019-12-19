import UIKit

final class SeasonCardCollectionCell: UICollectionViewCell {

    // MARK: - Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let textBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()

    private let labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
//        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .body, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
        layer.shadowOpacity = traitCollection.userInterfaceStyle == .some(.dark) ? 0 : 0.3
    }

    // MARK: - Helpers

    private func setupCardStyle() {
        contentView.layer.cornerCurve = .circular
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemBackground
        contentView.layer.masksToBounds = true

        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }

    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(labelStack)
        labelStack.insertSubview(textBackground, at: 0)
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            textBackground.leadingAnchor.constraint(equalTo: labelStack.leadingAnchor),
            textBackground.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor),
            textBackground.topAnchor.constraint(equalTo: labelStack.topAnchor),
            textBackground.bottomAnchor.constraint(equalTo: labelStack.bottomAnchor),

            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelStack.heightAnchor.constraint(equalTo: heightAnchor,
                                                   multiplier: 0.2)
        ])
    }

    // MARK: - Interface

    func configure(title: String?,
                   subtitle: String?,
                   image: UIImage?) {

        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = image
    }
}
