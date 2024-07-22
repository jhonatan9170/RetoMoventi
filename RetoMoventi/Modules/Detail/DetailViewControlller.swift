
import RxSwift
import DesignSystem
import MoventiCore

class DetailViewControlller: UIViewController {
    let disposeBag = DisposeBag()
    var accountModel: AccountModel!
    var movementViewModel: MovementsViewModel!
    
    lazy var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView(style: .medium)
       loader.translatesAutoresizingMaskIntoConstraints = false
       loader.color = .black
       loader.hidesWhenStopped = true
       loader.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
       view.addSubview(loader)
       return loader
   }()
    
    lazy var cardCuenta: FullInfoCardView = {
        let card = FullInfoCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        return card
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        configBindings()
        view.backgroundColor = .white
        self.title = "Consultas"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        cardCuenta.configure(model: accountModel)
    }
    
    lazy var tableMovimientos:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(MovementCardCell.self, forCellReuseIdentifier: MovementCardCell.cellIdentifier)
        view.addSubview(table)
        return table
    }()
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            cardCuenta.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            cardCuenta.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            cardCuenta.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            cardCuenta.heightAnchor.constraint(equalToConstant: 135),
            
            tableMovimientos.topAnchor.constraint(equalTo: cardCuenta.bottomAnchor, constant: 32),
            tableMovimientos.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            tableMovimientos.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            tableMovimientos.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalTo: view.widthAnchor),
            loader.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
}
