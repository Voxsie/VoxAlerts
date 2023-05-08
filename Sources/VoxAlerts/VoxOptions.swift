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
    
    public var backgroundColor: UIColor = .clear
    
    public var duration: VoxOptions.AlertDuration = .time(3)
    
    public var textColro: UIColor = .label
    
    public init() {
        
    }
}


