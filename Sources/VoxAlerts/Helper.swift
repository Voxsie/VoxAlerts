//
//  File.swift
//
//
//  Created by Илья Желтиков on 06.05.2023.
//

import Foundation
import UIKit

final class AlertHelper {
    
    var topConstraint: NSLayoutConstraint?
    
    var bottomConstraint: NSLayoutConstraint?
    
    var initialConstraint: NSLayoutConstraint?
    
    
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
            alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        switch(position) {
        case .top:
            if let top = viewController.view?.topAnchor {
                self.initialConstraint = alertView.bottomAnchor.constraint(equalTo: top, constant: 0)
                self.initialConstraint?.isActive = true
            }
        case .bottom:
            if let bottom = viewController.view?.bottomAnchor {
                self.initialConstraint = alertView.bottomAnchor.constraint(equalTo: bottom, constant: alertView.frame.height)
                self.initialConstraint?.isActive = true
            }
        }
    }
    
    public func makeAnimation(for alertView: VoxView, with position: VoxOptions.AlertPosition, on viewController: UIViewController) {
        switch(position) {
        case .top:
            if let topSafeArea = viewController.view?.safeAreaLayoutGuide.topAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: {
                    self.initialConstraint?.isActive = false
                    self.topConstraint = alertView.bottomAnchor.constraint(equalTo: topSafeArea, constant: alertView.frame.height)
                    self.topConstraint?.isActive = true
                    viewController.view.layoutIfNeeded()
                })
            }
        case .bottom:
            if let bottomSafeArea = viewController.view?.safeAreaLayoutGuide.bottomAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: {
                    self.initialConstraint?.isActive = false
                    self.bottomConstraint = alertView.bottomAnchor.constraint(equalTo: bottomSafeArea, constant: 0)
                    self.bottomConstraint?.isActive = true
                    viewController.view.layoutIfNeeded()
                })
            }
        }
    }
//    
//    public func dismissAlert() {
//        
//    }
    
    public func dismissAlert(for alertView: VoxView, with position: VoxOptions.AlertPosition, on viewController: UIViewController) {
        switch(position) {
        case .top:
            if let top = viewController.view?.topAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
                    self?.topConstraint?.isActive = false
                    self?.initialConstraint?.isActive = true
                    alertView.bottomAnchor.constraint(equalTo: top, constant: 0).isActive = true
                    viewController.view.layoutIfNeeded()
                }) { _ in
                    alertView.removeFromSuperview()
                }
            }
        case .bottom:
            if let bottom = viewController.view?.bottomAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
                    self?.bottomConstraint?.isActive = false
                    self?.initialConstraint?.isActive = true
                    viewController.view.layoutIfNeeded()
                }) { _ in
                    alertView.removeFromSuperview()
                }
            }
        }
    }
}
