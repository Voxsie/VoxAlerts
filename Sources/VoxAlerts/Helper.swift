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
    
    var alertView: VoxView
    
    var options: VoxOptions
    
    var viewController: UIViewController
    
    public init(alertView: VoxView, options: VoxOptions, viewController: UIViewController) {
        self.alertView = alertView
        self.options = options
        self.viewController = viewController
    }
    
    
    public func makeFeedback(_ option: VoxOptions.FeedbackType? = VoxOptions.FeedbackType.none) {
        if let feedbackType = option?.value {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(feedbackType)
        }
    }
    
    public func setupPosition() {
        viewController.view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 16),
            alertView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -16),
            alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        switch(options.position) {
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
    
    public func makeAnimation() {
        switch(options.position) {
        case .top:
            if let topSafeArea = viewController.view?.safeAreaLayoutGuide.topAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: {
                    self.initialConstraint?.isActive = false
                    self.topConstraint = self.alertView.bottomAnchor.constraint(equalTo: topSafeArea, constant: self.alertView.frame.height)
                    self.topConstraint?.isActive = true
                    self.viewController.view.layoutIfNeeded()
                })
            }
        case .bottom:
            if let bottomSafeArea = viewController.view?.safeAreaLayoutGuide.bottomAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: {
                    self.initialConstraint?.isActive = false
                    self.bottomConstraint = self.alertView.bottomAnchor.constraint(equalTo: bottomSafeArea, constant: 0)
                    self.bottomConstraint?.isActive = true
                    self.viewController.view.layoutIfNeeded()
                })
            }
        }
    }
    
    public func addDismissSwipe() {
        switch(options.position) {
        case .top:
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissAlert))
            swipe.direction = .up
            alertView.addGestureRecognizer(swipe)
        case .bottom:
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissAlert))
            swipe.direction = .down
            alertView.addGestureRecognizer(swipe)
        }
    }
    
    @objc
    public func dismissAlert() {
        switch(self.options.position) {
        case .top:
            if let top = viewController.view?.topAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
                    self?.topConstraint?.isActive = false
                    self?.initialConstraint?.isActive = true
                    self?.alertView.bottomAnchor.constraint(equalTo: top, constant: 0).isActive = true
                    self?.viewController.view.layoutIfNeeded()
                }) { _ in
                    if self.options.duration.getTime() < 0 {
                        self.alertView.removeFromSuperview()
                    }
                }
            }
        case .bottom:
            if let bottom = viewController.view?.bottomAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
                    self?.bottomConstraint?.isActive = false
                    self?.initialConstraint?.isActive = true
                    self?.alertView.bottomAnchor.constraint(equalTo: bottom, constant: self?.alertView.frame.height ?? 0).isActive = true
                    self?.viewController.view.layoutIfNeeded()
                }) { _ in
                    self.alertView.removeFromSuperview()
                }
            }
        }
    }
}
