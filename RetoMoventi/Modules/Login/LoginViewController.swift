
import DesignSystem
import RxSwift

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var loginViewModel: LoginViewModel!
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if let bundle = Bundle(identifier: "com.jhonatanChavez.DesignSystem"){
            imageView.image = UIImage(named: "Logo", in: bundle, with: nil)
        }
        view.addSubview(imageView)
        return imageView
    }()
    
     lazy var emailField: CustomTextField = {
        let emailField = CustomTextField()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.textField.placeholder = "Correo electrónico"
        emailField.configure(textfieldType: .email)
        view.addSubview(emailField)
        return emailField
    }()
    
     lazy var passwordField: CustomTextField = {
        let passwordField = CustomTextField()
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.textField.placeholder = "Contraseña"
        passwordField.configure(textfieldType: .password)
        view.addSubview(passwordField)
        return passwordField
    }()
     lazy var loginButton: CustomButton = {
        let loginButton = CustomButton(style: .filled)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        view.addSubview(loginButton)
        return loginButton
    }()
    
    private lazy var helloLabel: UILabel = {
        let helloLabel = UILabel()
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        helloLabel.text = "Hola "
        helloLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        helloLabel.textColor = .black
        return helloLabel
    }()
    
    private lazy var savedNameLabel: UILabel = {
        let savedNameLabel = UILabel()
        savedNameLabel.translatesAutoresizingMaskIntoConstraints = false
        savedNameLabel.text = "Jhonatan"
        savedNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        savedNameLabel.textColor = .black
        return savedNameLabel
    }()
    
     lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [helloLabel, savedNameLabel])
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .horizontal
        nameStackView.spacing = 0
        nameStackView.alignment = .center
        nameStackView.distribution = .equalSpacing
        view.addSubview(nameStackView)
        return nameStackView
    }()
    
    private lazy var componentsStackView: UIStackView = {
        let componentsStackView = UIStackView(arrangedSubviews: [nameStackView,emailField, passwordField, loginButton])
        componentsStackView.translatesAutoresizingMaskIntoConstraints = false
        componentsStackView.axis = .vertical
        componentsStackView.spacing = 16
        componentsStackView.alignment = .center
        componentsStackView.distribution = .equalSpacing
        view.addSubview(componentsStackView)
        return componentsStackView
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
        view.backgroundColor = .white
        setupConstraints()
        configBindings()
        validateUserInMemory()
    }

    private func validateUserInMemory() {
        
        if (self.getUser() != nil) && (self.getCorreo() != nil ) {
            savedNameLabel.text = self.getUser()
            nameStackView.isHidden = false
            emailField.isHidden = true
            emailField.textField.text = getCorreo() ?? ""
            emailField.textField.rx.text.onNext(self.getCorreo() ?? "")
        } else {
            nameStackView.isHidden = true
            emailField.isHidden = false
        }
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalToConstant: 135),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            componentsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            componentsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            componentsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            emailField.widthAnchor.constraint(equalTo: componentsStackView.widthAnchor),
            passwordField.widthAnchor.constraint(equalTo: componentsStackView.widthAnchor),

            loginButton.widthAnchor.constraint(equalToConstant: 150),
            
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalTo: view.widthAnchor),
            loader.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ])
    }

    
}
