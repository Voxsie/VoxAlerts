//
//  File.swift
//  
//
//  Created by Илья Желтиков on 08.04.2023.
//

import UIKit

final public class VoxView: UIView {
    
    fileprivate lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = ""
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    fileprivate let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = ""
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    fileprivate let stackLabel: UIStackView = {
        let stack = UIStackView()
         stack.translatesAutoresizingMaskIntoConstraints = false
         stack.axis = .vertical
         stack.spacing = 4
         stack.distribution = .fill
        return stack
    }()
    
    public init(alertType: VoxOptions.AlertType, title: String? = nil, text: String) {
        super.init(frame: UIScreen.main.bounds)
        
        switch(alertType) {
        case .success:
            backgroundColor = .specialSuccess
            logoImageView.image = UIImage(named: "alertSuccess")
            textLabel.text = text
        case .error:
            backgroundColor = .specialNegative
            logoImageView.image = UIImage(named: "alertError")
            textLabel.text = text
        case .system:
            backgroundColor = .systemBackground
            logoImageView.image = UIImage(named: "alertSystem")
            textLabel.text = text
        }
        
        textLabel.textColor = .label
        
        if title != nil {
            titleLabel.text = title
            stackLabel.addArrangedSubview(titleLabel)
        }
        stackLabel.addArrangedSubview(textLabel)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func setupView() {
        self.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            self.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 24),
            logoImageView.widthAnchor.constraint(equalToConstant: 24),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
        
        addSubview(stackLabel)
        NSLayoutConstraint.activate([
            stackLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            stackLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
        
        titleLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.25)
        titleLabel.lineBreakMode = .byWordWrapping
        
        textLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.25)
        textLabel.lineBreakMode = .byWordWrapping

    }
}
