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
    
}
