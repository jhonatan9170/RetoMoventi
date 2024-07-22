import UIKit

public class MovementCardView: UIView {
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let amountLabel = UILabel()
    private let noMovementsLabel = UILabel()
    
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
        addBorderAndShadow()
        addViews()
        setupConstraints()
    }
    
    private func configureSubcomponents() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        amountLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        amountLabel.textAlignment = .right
        
        noMovementsLabel.text = "Aún no tienes movimientos"
        noMovementsLabel.textAlignment = .center
        noMovementsLabel.isHidden = true
    }
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(amountLabel)
        addSubview(noMovementsLabel)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        noMovementsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noMovementsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noMovementsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
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
    
    /// 1 - en proceso
    /// 2 - nuevo ingreso
    /// 3 - nuevo ingreso
    public func configure(with title: String?, date: String?, amount: String?, state: Int?) {
        if let title = title, let date = date, let amount = amount?.formattedAsCurrency, let state = state {
            titleLabel.text = title
            dateLabel.text = date
            amountLabel.text = amount
            
            switch state {
            case 1:
                amountLabel.textColor = .customGris
            case 2:
                amountLabel.textColor = .customGreen
                amountLabel.text = "+ \(amount)"
            case 3:
                amountLabel.textColor = .customRed
                amountLabel.text = "- \(amount)"
            default:
                amountLabel.textColor = .black
            }
            
            titleLabel.isHidden = false
            dateLabel.isHidden = false
            amountLabel.isHidden = false
            noMovementsLabel.isHidden = true
        } else {
            titleLabel.isHidden = true
            dateLabel.isHidden = true
            amountLabel.isHidden = true
            noMovementsLabel.isHidden = false
        }
    }
}
