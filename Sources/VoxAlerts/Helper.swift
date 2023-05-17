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
    
    weak var alertView: UIView?
    
    var options: VoxOptions
    
    weak var viewController: UIViewController?
    
    var isNeedToRemoveFromSuperView: Bool = true
    
    public init(alertView: UIView, options: VoxOptions, viewController: UIViewController) {
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
        guard let viewController = viewController else { return }
        viewController.view.addSubview(alertView ?? UIView())
        alertView?.translatesAutoresizingMaskIntoConstraints = false
        
        guard let alertView = alertView else { return }
        
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
        guard let viewController = viewController else { return }
        switch(options.position) {
        case .top:
            if let topSafeArea = viewController.view?.safeAreaLayoutGuide.topAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [options.animation], animations: {
                    self.initialConstraint?.isActive = false
                    self.topConstraint = self.alertView?.bottomAnchor.constraint(equalTo: topSafeArea, constant: self.alertView?.frame.height ?? 0)
                    self.topConstraint?.isActive = true
                    self.viewController?.view.layoutIfNeeded()
                })
            }
        case .bottom:
            if let bottomSafeArea = viewController.view?.safeAreaLayoutGuide.bottomAnchor {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [options.animation], animations: {
                    self.initialConstraint?.isActive = false
                    self.bottomConstraint = self.alertView?.bottomAnchor.constraint(equalTo: bottomSafeArea, constant: 0)
                    self.bottomConstraint?.isActive = true
                    self.viewController?.view.layoutIfNeeded()
                })
            }
        }
    }
    
    public func addDismissSwipe() {
        alertView?.isUserInteractionEnabled = true
        switch(options.position) {
        case .top:
            let swipe = UIPanGestureRecognizer(target: self, action: #selector(dismissAlert))
            alertView?.addGestureRecognizer(swipe)
        case .bottom:
            let swipe = UIPanGestureRecognizer(target: self, action: #selector(dismissAlert))
            alertView?.addGestureRecognizer(swipe)
        }
    }
    
    @objc
    public func dismissAlert() {
        guard let viewController = viewController else { return }
        if isNeedToRemoveFromSuperView {
            switch(self.options.position) {
            case .top:
                if let top = viewController.view?.topAnchor {
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: [options.animation], animations: { [weak self] in
                        self?.topConstraint?.isActive = false
                        self?.initialConstraint?.isActive = true
                        self?.alertView?.bottomAnchor.constraint(equalTo: top, constant: 0).isActive = true
                        self?.viewController?.view.layoutIfNeeded()
                    }) { [weak self] _ in
                        if self?.isNeedToRemoveFromSuperView == true {
                            self?.alertView?.gestureRecognizers = nil
                            self?.alertView?.removeFromSuperview()
                            self?.isNeedToRemoveFromSuperView = false
                        }
                    }
                }
            case .bottom:
                if let bottom = viewController.view?.bottomAnchor {
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: [options.animation], animations: { [weak self] in
                        self?.bottomConstraint?.isActive = false
                        self?.initialConstraint?.isActive = true
                        self?.alertView?.bottomAnchor.constraint(equalTo: bottom, constant: self?.alertView?.frame.height ?? 0).isActive = true
                        self?.viewController?.view.layoutIfNeeded()
                    }) { [weak self] _ in
                        if self?.isNeedToRemoveFromSuperView == true {
                            self?.alertView?.removeFromSuperview()
                            self?.isNeedToRemoveFromSuperView = false
                        }
                    }
                }
            }
        }
    }
}

