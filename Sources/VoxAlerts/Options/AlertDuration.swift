//
//  AlertDuration.swift
//  
//
//  Created by Илья Желтиков on 07.05.2023.
//

import Foundation

public extension VoxOptions {
    
    enum AlertDuration {
        case time(Double)
        case byDismiss
        
        func getTime() -> Double {
            switch self {
            case .time(let value):
                return value
            case .byDismiss:
                return -1.0
            }
        }
    }
}
