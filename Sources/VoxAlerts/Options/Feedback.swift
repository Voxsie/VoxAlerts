//
//  File.swift
//  
//
//  Created by Илья Желтиков on 08.04.2023.
//

import UIKit

public extension VoxOptions {
    
    enum FeedbackType {
        case success
        case system
        case error
        case none
        
        @available(iOS 10.0, *)
        var value: UINotificationFeedbackGenerator.FeedbackType? {
            switch self {
            case .success:
                return .success
            case .system:
                return .warning
            case .error:
                return .error
            case .none:
                return nil
            }
        }
    }
}
