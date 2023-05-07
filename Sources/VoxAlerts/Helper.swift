//
//  File.swift
//  
//
//  Created by Илья Желтиков on 06.05.2023.
//

import Foundation
import UIKit

final class AlertHelper {
    
    public func makeFeedback(_ option: VoxOptions.FeedbackType) {
        if let feedbackType = option.value {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(feedbackType)
        }
    }
    
    public func setupPosition(for alertView: VoxView, with position: VoxOptions.AlertPosition, on viewController: UIViewController) {
        viewController.view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            
        ])
        
        switch(position) {
        case .top:
            alertView.frame.origin.y = UIScreen.main.bounds.minY - alertView.frame.size.height
        case .bottom:
            alertView.frame.origin.y = UIScreen.main.bounds.height
        }
    }
}
