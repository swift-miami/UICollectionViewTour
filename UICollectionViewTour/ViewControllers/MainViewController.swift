import UIKit

final class MainViewController: UITableViewController {

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

    private enum Constants {
        static let cellId = "MainVCCellId"
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        title = "UICollectionView Tour"
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }

    // MARK: - Helpers
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Constants.cellId)
        tableView.rowHeight = 64

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Row.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId,
                                                 for: indexPath)

        let row = Row(rawValue: indexPath.row)
        cell.imageView?.image = row?.image
        cell.imageView?.tintColor = row?.tintColor
        cell.textLabel?.text = row?.title
        cell.textLabel?.textColor = row?.tintColor
        cell.textLabel?.font = .preferredFont(forTextStyle: .title3)
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let row = Row(rawValue: indexPath.row) else { return }

        let viewController: UIViewController
        
        switch row {
        case .flowLayout:       viewController = FlowLayoutViewController()
        case .compositional:    viewController = UIViewController()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }

}
