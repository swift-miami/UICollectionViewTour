import UIKit

final class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties

    private enum Row: Int, CaseIterable {
        case flowLayout, compositional

        static var count: Int { Row.allCases.count }

        var title: String {
            switch self {
            case .flowLayout:       return "Flow Layout"
            case .compositional:    return "Compositional"
            }
        }

        var image: UIImage? {
            switch self {
            case .flowLayout:       return UIImage(systemName: "flowchart.fill")
            case .compositional:    return UIImage(systemName: "rectangle.3.offgrid.fill")
            }
        }

        var tintColor: UIColor? {
            switch self {
            case .flowLayout:       return .systemPurple
            case .compositional:    return .systemOrange
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        title = "UICollectionView Tour"
        collectionView.backgroundColor = .systemBackground
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { context in
            self.collectionViewLayout.invalidateLayout()

        }, completion: nil)
    }

    // MARK: - Helpers
    
    private func setupCollectionView() {
        collectionView.registerCell(cellClass: ListCollectionCell.self)
    }

    // MARK: - Table view data source
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        Row.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: ListCollectionCell = collectionView.dequeueReusableCell(for: indexPath)

        let row = Row(rawValue: indexPath.row)

        cell.configure(with: row?.title,
                       image: row?.image,
                       tintColor: row?.tintColor)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {

        guard let row = Row(rawValue: indexPath.row) else { return }

        let viewController: UIViewController

        switch row {
        case .flowLayout:       viewController = FlowLayoutViewController()
        case .compositional:    viewController = UIViewController()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.width,
                      height: 60)
    }
}
