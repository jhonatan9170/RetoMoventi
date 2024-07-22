import UIKit

public enum textfieldType {
    case email
    case password
    case normal
    case dni
}
public class CustomTextField: UIView {
    
    public let textField = UITextField()
    private let supportingLabel = UILabel()
    private let togglePasswordVisibilityImageView = UIImageView()
    private var isPasswordVisible = false
    private var textfieldType: textfieldType = .normal
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        configureSubcomponents()
        addViews()
        setupConstraints()
        setupTogglePasswordVisibilityImageView()
    }
    
    private func configureSubcomponents() {
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.font = UIFont.systemFont(ofSize: 14)
        
        supportingLabel.font = UIFont.systemFont(ofSize: 12)
        supportingLabel.textColor = .gray
        supportingLabel.text = ""
        
        togglePasswordVisibilityImageView.image = UIImage(named:  "eye-hide", in: Bundle(for: CustomTextField.self), compatibleWith: nil)
        togglePasswordVisibilityImageView.tintColor = .gray
        togglePasswordVisibilityImageView.isHidden = true
        togglePasswordVisibilityImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility))
        togglePasswordVisibilityImageView.addGestureRecognizer(tapGesture)
        textField.addTarget(self, action: #selector(validateTextfield), for: .editingChanged)
    }
    
    private func addViews() {
        addSubview(textField)
        addSubview(supportingLabel)
    }
    
    private func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        supportingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            supportingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            supportingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            supportingLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            supportingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupTogglePasswordVisibilityImageView() {
        togglePasswordVisibilityImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(togglePasswordVisibilityImageView)
        
        NSLayoutConstraint.activate([
            togglePasswordVisibilityImageView.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -8),
            togglePasswordVisibilityImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            togglePasswordVisibilityImageView.widthAnchor.constraint(equalToConstant: 24),
            togglePasswordVisibilityImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        textField.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        textField.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye-show" : "eye-hide"
        togglePasswordVisibilityImageView.image =  UIImage(named:  imageName, in: Bundle(for: CustomTextField.self), compatibleWith: nil)
    }
    
    private func addBorderAndShadow() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        backgroundColor = .white
    }
   @objc private func validateTextfield() {
       switch textfieldType {
       case .email:
           validateEmail()
       case .password:
           validatePassword()
       default:
           break
       }
   }
    public func validateEmail() -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            showError("El campo no puede estar vacío")
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailPred.evaluate(with: text) {
            hideError()
            return true
        } else {
            showError("Correo electrónico inválido")
            return false
        }
    }
    
    public func validateDNI() -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            showError("El campo DNI no puede estar vacío")
            return false
        }
        
        let dniRegex = "^[0-9]{8}$"
        let dniPred = NSPredicate(format:"SELF MATCHES %@", dniRegex)
        
        if dniPred.evaluate(with: text) {
            hideError()
            return true
        } else {
            showError("DNI invalido")
            return false
        }
    }
    
    public func validatePassword(minLength: Int = 8) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            showError("El campo no puede estar vacío")
            return false
        }
        
        if text.count < minLength {
            showError("La contraseña debe tener al menos \(minLength) caracteres")
            return false
        }
        
        let numberRegEx = ".*[0-9]+.*"
        let numberPred = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        
        if !numberPred.evaluate(with: text) {
            showError("La contraseña debe contener al menos un número")
            return false
        }
        
        hideError()
        return true
    }
    
    private func showError(_ message: String) {
        supportingLabel.text = message
        supportingLabel.textColor = .red
        supportingLabel.isHidden = false
    }
    
    private func hideError() {
        supportingLabel.textColor = .gray
        supportingLabel.isHidden = true
    }
    
    public func configure(textfieldType: textfieldType) {
        self.textfieldType = textfieldType
        textField.isSecureTextEntry = textfieldType == .password
        if textfieldType == .dni {
            textField.keyboardType = .numberPad
        }
    }
}
