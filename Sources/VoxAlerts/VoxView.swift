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
        imageView.image = UIImage(named: "alertSystem")
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
    
    public init(options: VoxOptions, title: String? = nil, text: String = "", customImage: UIImage? = nil) {
        super.init(frame: UIScreen.main.bounds)
        
        switch(options.type) {
        case .success:
            backgroundColor = .specialSuccess
            logoImageView.image = customImage != nil ? customImage : Assets.getImage(named: "alertSuccess")
            textLabel.text = text
        case .error:
            backgroundColor = .specialNegative
            logoImageView.image = customImage != nil ? customImage : Assets.getImage(named: "alertError")
            textLabel.text = text
        case .system, .none:
            backgroundColor = Assets.getColor(named: "VoxAlertSystemBackgroundColor")
            logoImageView.image = customImage != nil ? customImage : Assets.getImage(named: "alertSystem")
            textLabel.text = text
            let textColor = Assets.getColor(named: "VoxAlertSystemTextColor")
            titleLabel.textColor = textColor
            textLabel.textColor = textColor
        }
        if title != nil {
            titleLabel.text = title
            stackLabel.addArrangedSubview(titleLabel)
            
            if options.textFont?.titleFont != nil {
                titleLabel.font = options.textFont?.titleFont
            }
        }
        
        if options.textFont?.subtitleFont != nil {
            textLabel.font = options.textFont?.subtitleFont
        }
        
        if options.backgroundColor != nil {
            backgroundColor = options.backgroundColor
        }
        
        stackLabel.addArrangedSubview(textLabel)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func setupView() {
        self.layer.cornerRadius = 10
        
        translatesAutoresizingMaskIntoConstraints = false
 
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
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        
        titleLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.25)
        titleLabel.lineBreakMode = .byWordWrapping
        
        textLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.25)
        textLabel.lineBreakMode = .byWordWrapping

    }
}
