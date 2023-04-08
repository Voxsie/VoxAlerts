//
//  Extensions.swift
//  
//
//  Created by Илья Желтиков on 08.04.2023.
//

import UIKit

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        
        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

extension UIColor {
    static var specialNegative: UIColor { return UIColor(red: 255/255, green: 61/255, blue: 77/255, alpha: 1) }
    
    static var specialWarning: UIColor { return UIColor(red: 255/255, green: 166/255, blue: 77/255, alpha: 1) }
    
    static var specialSuccess: UIColor { return UIColor(red: 58/255, green: 194/255, blue: 112/255, alpha: 1) }
}
