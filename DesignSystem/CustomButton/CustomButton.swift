import UIKit

public enum ButtonStyle {
    case text
    case filled
    case outlined
}

public class CustomButton: UIButton {
    
    private var style: ButtonStyle = .text
    public override var isEnabled: Bool {
        didSet {
            isEnabled ? configureStyle() : Disable()
        }
    }
    public init(style: ButtonStyle) {
        super.init(frame: .zero)
        self.style = style
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        configureStyle()
        setupConstraints()
    }
    
    private func configureStyle() {
        switch style {
        case .text:
            setTitleColor(.gray, for: .normal)
            backgroundColor = .clear
        case .filled:
            setTitleColor(.white, for: .normal)
            backgroundColor = .customFucsia
            layer.cornerRadius = 20
        case .outlined:
            setTitleColor(.systemPink, for: .normal)
            backgroundColor = .clear
            layer.cornerRadius = 20
            layer.borderWidth = 2
            layer.borderColor = UIColor.customFucsia.cgColor
        }
        
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private func Disable() {
        backgroundColor = .gray
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
}
