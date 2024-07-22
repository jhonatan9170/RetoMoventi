import UIKit
import MoventiCore

public class MovementCardCell: UITableViewCell {
    
    public let movementView = MovementCardView()
    public static let cellIdentifier = "MovementsCell"
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }
    
    private func setupCell() {
        movementView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movementView)
        
        NSLayoutConstraint.activate([
            movementView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movementView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movementView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movementView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        movementView.layer.shadowColor = UIColor.black.cgColor
        movementView.layer.shadowOpacity = 0.1
        movementView.layer.shadowOffset = CGSize(width: 0, height: 2)
        movementView.layer.shadowRadius = 4
    }
    
    public func configure(model: MovementModel) {
        movementView.configure(with: model.title, date: model.date, amount: model.amount, state: model.state)
    }
}
