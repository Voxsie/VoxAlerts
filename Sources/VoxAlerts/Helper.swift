//
//  File.swift
//
//
//  Created by Илья Желтиков on 06.05.2023.
//

import Foundation
import UIKit

final class AlertHelper {
    
    public func makeFeedback(_ option: VoxOptions.FeedbackType? = VoxOptions.FeedbackType.none) {
        if let feedbackType = option?.value {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(feedbackType)
        }
    }
    
    public func setupPosition(for alertView: VoxView, with position: VoxOptions.AlertPosition, on viewController: UIViewController) {
        viewController.view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 16),
            alertView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -16),
            alertView.heightAnchor.constraint(equalToConstant: 69)
        ])
        
        switch(position) {
        case .top:
            if let top = viewController.view?.topAnchor {
                alertView.bottomAnchor.constraint(equalTo: top, constant: 0).isActive = true
            }
        case .bottom:
            if let bottom = viewController.view?.bottomAnchor {
                alertView.bottomAnchor.constraint(equalTo: bottom, constant: alertView.frame.height).isActive = true
            }
        }
    }
    
    public func makeAnimation(for alertView: VoxView, with position: VoxOptions.AlertPosition, on viewController: UIViewController) {
        switch(position) {
        case .top:
            if let top = viewController.view?.safeAreaLayoutGuide.topAnchor {
                UIView.animate(withDuration: 0.5, animations: {
                    alertView.bottomAnchor.constraint(equalTo: top, constant: -69).isActive = true
                    viewController.view.layoutIfNeeded()
                })
            }
        case .bottom:
            if let bottom = viewController.view?.bottomAnchor {
                UIView.animate(withDuration: 0.5, animations: {
                    alertView.bottomAnchor.constraint(equalTo: bottom, constant: 0).isActive = true
                    viewController.view.layoutIfNeeded()
                })
            }
        }
    }
    
    public func makeAnimationFromBottom(for alertView: VoxView, with position: VoxOptions.AlertPosition, on viewController: UIViewController) {
        viewController.view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 16),
            alertView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -16),
            alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 69)
        ])
        
        if let bottom = viewController.view?.bottomAnchor {
            alertView.bottomAnchor.constraint(equalTo: bottom, constant: 69).isActive = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            if let bottom = viewController.view?.bottomAnchor {
                UIView.animate(withDuration: 0.5, animations: {
                    alertView.bottomAnchor.constraint(equalTo: bottom, constant: 0).isActive = true
                    viewController.view.layoutIfNeeded()
                })
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if let bottom = viewController.view?.bottomAnchor {
                UIView.animate(withDuration: 0.5, animations: {
                    alertView.bottomAnchor.constraint(equalTo: bottom, constant: 69).isActive = true
                    viewController.view.layoutIfNeeded()
                })
            }
        }
    }
}
