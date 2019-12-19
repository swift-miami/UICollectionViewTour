
import UIKit

final class CompositionalLayoutViewController: UIViewController {

    // MARK: - Properties
    typealias Element = Season
    typealias DemoSnapshot = NSDiffableDataSourceSnapshot<Section, Element>
    typealias DemoDiffableDataSource = UICollectionViewDiffableDataSource<Section, Element>

    enum Section: CaseIterable {
        case coverFlow, groupGrid

        var title: String {
            switch self {
            case .coverFlow: return "Cover Flow"
            case .groupGrid: return "Group Grid"
            }
        }
    }

    private let dataSource = Season.theWireSeasons

    private lazy var layout: UICollectionViewLayout = {

        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, environment -> NSCollectionLayoutSection? in

            let inset = CGFloat(16)
            let isCompact = environment.container.effectiveContentSize.width < 450
            let columns = isCompact ? 1 : 2

            let section = NSCollectionLayoutSection
                .grid(itemHeight: .absolute(300),
                      itemSpacing: inset,
                      numberOfColumns: columns)
                .withSectionHeader(estimatedHeight: 44,
                                   kind: CollectionHeaderView.viewReuseIdentifier)
                .withContentInsets(leading: inset,
                                   bottom: inset,
                                   trailing: inset)

            return section
        }
        return layout
    }()

    private lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true

        collectionView.registerCell(cellClass: SeasonCardCollectionCell.self)
        collectionView.registerSupplementaryView(viewClass: CollectionHeaderView.self)
        return collectionView
    }()

    private lazy var diffableDataSource: DemoDiffableDataSource = {

        // Setup cells
        let diffableDataSource = DemoDiffableDataSource(collectionView: collectionView) { [weak self]
            (collectionView, indexPath, element) -> UICollectionViewCell? in

            let cell: SeasonCardCollectionCell = collectionView.dequeueReusableCell(for: indexPath)

            let image = UIImage(named: element.imageName)
            cell.configure(title: element.name,
                           subtitle: element.year,
                           image: image)
            return cell
        }

        // Setup headers
        diffableDataSource.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath -> UICollectionReusableView? in

            let section = diffableDataSource.snapshot().sectionIdentifiers[indexPath.section]
            let header: CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(indexPath: indexPath)
            header.configure(with: section.title)

            return header
        }

        return diffableDataSource
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupDataSource()
    }

    // MARK: - Helpers

    private func setupDataSource() {
        let snapshot = buildSnapshot(with: dataSource)
        diffableDataSource.apply(snapshot)
    }

    private func setupLayout() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func buildSnapshot(with dataSource: [Season]) -> DemoSnapshot {
        var snapshot = DemoSnapshot()
        snapshot.appendSections([.coverFlow])

        for section in snapshot.sectionIdentifiers {
            snapshot.appendItems(dataSource, toSection: section)
        }

        return snapshot
    }
}
