import UIKit
import MoventiCore

public class FullInfoCardView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let currencyLabel = UILabel()
    private let amountLabel = UILabel()
    private let accountNumberTitleLabel = UILabel()
    private let accountNumberLabel = UILabel()
    private let copyButton = CustomButton(style: .filled)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        configureSubcomponents()
        addBorderAndShadow()
        addViews()
        setupConstraints()
    }
    
    private func configureSubcomponents() {
        imageView.contentMode = .scaleAspectFit
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        currencyLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        amountLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        accountNumberTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        accountNumberLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        accountNumberTitleLabel.textColor = .darkGray
        accountNumberLabel.textColor = .darkGray
        accountNumberTitleLabel.text = "Número de cuenta"
        
        copyButton.setTitle("Copiar", for: .normal)
        copyButton.addTarget(self, action: #selector(copyAccountNumber), for: .touchUpInside)
    }
    
    private func addViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(currencyLabel)
        addSubview(amountLabel)
        addSubview(accountNumberTitleLabel)
        addSubview(accountNumberLabel)
        addSubview(copyButton)
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        accountNumberTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        accountNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            currencyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            currencyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            amountLabel.centerYAnchor.constraint(equalTo: currencyLabel.centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 5),
            
            accountNumberTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            accountNumberTitleLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 10),
            
            accountNumberLabel.leadingAnchor.constraint(equalTo: accountNumberTitleLabel.leadingAnchor),
            accountNumberLabel.topAnchor.constraint(equalTo: accountNumberTitleLabel.bottomAnchor, constant: 2),
            
            copyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            copyButton.centerYAnchor.constraint(equalTo: accountNumberLabel.centerYAnchor)
        ])
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
    
    @objc private func copyAccountNumber() {
        UIPasteboard.general.string = accountNumberLabel.text
    }
    
    public func configure(model: AccountModel) {
        imageView.image = UIImage(named: model.imageName, in: Bundle(for: AccountCardCell.self), compatibleWith: nil)
        titleLabel.text = model.title
        currencyLabel.text = model.currency
        amountLabel.text = model.amount.formattedAsCurrency
        accountNumberLabel.text = model.accountNumber
    }
}
