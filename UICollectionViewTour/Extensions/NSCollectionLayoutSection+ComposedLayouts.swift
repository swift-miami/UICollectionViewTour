import UIKit

extension NSCollectionLayoutSection {

    static func list(estimatedHeight: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    static func grid(itemHeight: NSCollectionLayoutDimension,
                     itemSpacing: CGFloat,
                     numberOfColumns: Int) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: numberOfColumns)
        group.interItemSpacing = .fixed(itemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = itemSpacing

        return section
    }

    static func nestedGroup() -> NSCollectionLayoutSection {
        
        let leadingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension: .fractionalHeight(1.0)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let trailingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.3)))
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                               heightDimension: .fractionalHeight(1.0)),
            subitem: trailingItem, count: 2)

        let nestedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.4)),
            subitems: [leadingItem, trailingGroup])
        let section = NSCollectionLayoutSection(group: nestedGroup)
        return section
    }

    @discardableResult
    func withSectionHeader(estimatedHeight: CGFloat, kind: String) -> NSCollectionLayoutSection {
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(estimatedHeight))

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: kind,
            alignment: .top)
        self.boundarySupplementaryItems = [sectionHeader]
        return self
    }

    @discardableResult
    func withContentInsets(top: CGFloat = 0,
                          leading: CGFloat = 0,
                          bottom: CGFloat = 0,
                          trailing: CGFloat = 0) -> NSCollectionLayoutSection {

        self.contentInsets = NSDirectionalEdgeInsets(top: top,
                                                     leading: leading,
                                                     bottom: bottom,
                                                     trailing: trailing)
        return self
    }
}

