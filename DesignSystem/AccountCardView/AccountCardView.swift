import UIKit
import MoventiCore

public class AccountCardView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let currencyLabel = UILabel()
    private let amountLabel = UILabel()
    private let arrowImageView = UIImageView()
    
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
        addViews()
        setupConstraints()
        addBorderAndShadow()
    }
    
    private func configureSubcomponents() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        currencyLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        amountLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        arrowImageView.image = UIImage(named: "arrow-icon", in: Bundle(for: AccountCardCell.self), compatibleWith: nil)
        arrowImageView.contentMode = .scaleAspectFit
        
    }
    
    private func addViews(){
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(currencyLabel)
        addSubview(amountLabel)
        addSubview(arrowImageView)
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            currencyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            currencyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            currencyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            amountLabel.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 5),
            amountLabel.centerYAnchor.constraint(equalTo: currencyLabel.centerYAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func addBorderAndShadow(){
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        backgroundColor = .white
    }
    
    public func configure(model: AccountModel) {
        imageView.image = UIImage(named: model.imageName, in: Bundle(for: AccountCardCell.self), compatibleWith: nil)
        titleLabel.text = model.title
        currencyLabel.text = model.currency
        amountLabel.text = model.amount.formattedAsCurrency
    }
}
