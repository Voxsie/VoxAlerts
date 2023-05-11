//
//  VoxOptions.swift
//
//
//  Created by Илья Желтиков on 08.04.2023.
//

import Foundation
import UIKit

public struct VoxOptions {
    
    public var type: VoxOptions.AlertType? = .success
    
    public var hapticFeedback: VoxOptions.FeedbackType = .success
    
    public var position: VoxOptions.AlertPosition = .top
    
    public var backgroundColor: UIColor? = nil
    
    public var duration: VoxOptions.AlertDuration = .time(3)
    
    public var textColor: UIColor? = nil
    
    public var textFont: VoxOptions.AlertFont? = nil
    
    public var animation: UIView.AnimationOptions = .curveEaseOut
    
    public init(type: VoxOptions.AlertType? = nil,
                hapticFeedback: VoxOptions.FeedbackType = VoxOptions.FeedbackType.none,
                position: VoxOptions.AlertPosition = VoxOptions.AlertPosition.bottom,
                backgroundColor: UIColor? = nil,
                duration: VoxOptions.AlertDuration = VoxOptions.AlertDuration.time(3),
                textColor: UIColor? = nil,
                textFont: VoxOptions.AlertFont? = nil, animation: UIView.AnimationOptions)
    {
        self.type = type
        self.hapticFeedback = hapticFeedback
        self.position = position
        self.backgroundColor = backgroundColor
        self.duration = duration
        self.textColor = textColor
        self.textFont = textFont
        self.animation = animation
    }
    
    public init() {
        
    }
}


