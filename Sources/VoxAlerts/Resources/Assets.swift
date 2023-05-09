//
//  File.swift
//  
//
//  Created by Илья Желтиков on 07.05.2023.
//

import Foundation
import UIKit

class Assets {
    static func getImage(named name: String) -> UIImage? {
        let bundle = Bundle.module
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
    
    static func getColor(named name: String) -> UIColor? {
        let bundle = Bundle.module
        return UIColor(named: name, in: bundle, compatibleWith: nil)
    }
}
