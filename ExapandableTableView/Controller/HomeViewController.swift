import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    fileprivate let viewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let tableView = tableView {
            viewModel.reloadSections = {(section: Int, indexpaths: [IndexPath], isInserting: Bool) in
                if isInserting {
                    tableView.insertRows(at: indexpaths, with: .fade)
                } else {
                    tableView.deleteRows(at: indexpaths, with: .fade)
                }
                tableView.beginUpdates()
                tableView.reloadSections([section], with: .fade)
                tableView.endUpdates()
            }
            
            tableView.dataSource = viewModel
            tableView.delegate = viewModel
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
            tableView.sectionHeaderHeight = 50
            tableView.register(CategoryItemView.nib, forCellReuseIdentifier: CategoryItemView.identifier)
            tableView.register(CategoryHeaderView.nib, forHeaderFooterViewReuseIdentifier: CategoryHeaderView.identifier)
        }
    }
}


