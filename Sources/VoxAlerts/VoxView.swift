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
    
<<<<<<< Updated upstream
    init(alertType: VoxOptions.AlertType, title: String? = nil, text: String) {
=======
    public init(alertType: VoxOptions.AlertType = .system, title: String? = nil, text: String = "") {
>>>>>>> Stashed changes
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
            textLabel.text = text
            textLabel.textColor = .label
        }
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
        
        let widthConstraint = NSLayoutConstraint(item: self,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: UIScreen.main.bounds.width - 32)

        let heightConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .height,
                                                   relatedBy: .greaterThanOrEqual,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1,
                                                   constant: 48)
        
        self.addConstraints([widthConstraint, heightConstraint])
        
        let heightImageConstraint = NSLayoutConstraint(item: logoImageView,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1,
                                                   constant: 24)

        let widthImageConstraint = NSLayoutConstraint(item: logoImageView,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 24)

        // Создаем констрейнт для левого края
        let leadingConstraint = NSLayoutConstraint(item: logoImageView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: self,
                                                     attribute: .leading,
                                                     multiplier: 1,
                                                     constant: 12)

        // Создаем констрейнт для верхнего края
        let topConstraint = NSLayoutConstraint(item: logoImageView,
                                                 attribute: .top,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .top,
                                                 multiplier: 1,
                                                 constant: 12)

        self.addConstraints([heightImageConstraint, widthImageConstraint,
                            leadingConstraint, topConstraint])
        
        // Добавляем констрейнты к view
        self.addSubview(logoImageView)

        titleLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.25)
        titleLabel.lineBreakMode = .byWordWrapping
        
        textLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.25)
        textLabel.lineBreakMode = .byWordWrapping
        
        addSubview(stackLabel)
        let topStackConstraint = NSLayoutConstraint(item: stackLabel,
                                                 attribute: .top,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .top,
                                                 multiplier: 1,
                                                 constant: 8)

        let leadingStackConstraint = NSLayoutConstraint(item: stackLabel,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: logoImageView,
                                                     attribute: .trailing,
                                                     multiplier: 1,
                                                     constant: 8)

        let trailingStackConstraint = NSLayoutConstraint(item: stackLabel,
                                                      attribute: .trailing,
                                                      relatedBy: .equal,
                                                      toItem: self,
                                                      attribute: .trailing,
                                                      multiplier: 1,
                                                      constant: -12)

        // Создаем констрейнт для нижнего края
        let bottomStackConstraint = NSLayoutConstraint(item: stackLabel,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: -12)

        self.addSubview(stackLabel)
        self.addConstraints([topStackConstraint, leadingStackConstraint,
                             trailingStackConstraint, bottomStackConstraint])

        NSLayoutConstraint.activate(constraints)
    }
}
