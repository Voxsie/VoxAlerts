//
//  VoxOptions.swift
//  
//
//  Created by Илья Желтиков on 08.04.2023.
//

import Foundation

public struct VoxOptions {
    
    public var type: VoxOptions.AlertType? = .success
    
    public var hapticFeedback: VoxOptions.FeedbackType = .success
    
    public var position: VoxOptions.AlertPosition = .top
}


