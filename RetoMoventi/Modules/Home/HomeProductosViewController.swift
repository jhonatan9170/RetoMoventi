
import DesignSystem
import RxSwift

class HomeProductosViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var accountViewModel: AccountsViewModel!
    
    lazy var productsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Productos"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        view.addSubview(label)
        return label
    }()
    
    lazy var tableProductos: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(AccountCardCell.self, forCellReuseIdentifier: AccountCardCell.cellIdentifier)
        view.addSubview(table)
        return table
    }()
    
    lazy var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView(style: .medium)
       loader.translatesAutoresizingMaskIntoConstraints = false
       loader.color = .black
       loader.hidesWhenStopped = true
       loader.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
       view.addSubview(loader)
       return loader
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        configBindings()
        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            productsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableProductos.topAnchor.constraint(equalTo: productsLabel.bottomAnchor, constant: 16),
            tableProductos.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableProductos.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableProductos.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalTo: view.widthAnchor),
            loader.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
}
