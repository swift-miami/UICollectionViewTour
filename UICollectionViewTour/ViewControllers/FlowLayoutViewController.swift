import UIKit

final class FlowLayoutViewController: UIViewController {

    // MARK: - Properties

    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(16)
        layout.sectionInset = UIEdgeInsets(top: spacing,
                                           left: spacing,
                                           bottom: spacing,
                                           right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cellClass: ImageCollectionViewCell.self)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()

        setupLayout()
        view.backgroundColor = .systemGroupedBackground
        title = "UICollectionViewFlowLayout"
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { context in
            self.layout.invalidateLayout()

        }, completion: nil)
    }

    // MARK: - Helpers

    private func setupLayout() {
        view.addSubview(collectionView)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension FlowLayoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return MockData.theWireCast.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let name = MockData.theWireCast[indexPath.row]
        cell.configure(with: name,
                       image: UIImage(systemName: "wand.and.stars"))
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FlowLayoutViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return itemSize(in: collectionView.bounds, with: layout)
    }

    func itemSize(in bounds: CGRect,
                  with layout: UICollectionViewFlowLayout) -> CGSize {

        // Alternative to calculate width
//        let isCompact = traitCollection.horizontalSizeClass == .compact
        let isCompact = bounds.width < 375
        let columns: CGFloat = isCompact ? 1 : 2

        var insets = layout.sectionInset.left
            + layout.sectionInset.right
            + layout.minimumInteritemSpacing

        if isCompact {
            insets -= layout.minimumInteritemSpacing
        }

        let width = (bounds.width -  insets) / columns
        let height = isCompact ? 60 : width / 3

        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDelegate

extension FlowLayoutViewController: UICollectionViewDelegate {

}
