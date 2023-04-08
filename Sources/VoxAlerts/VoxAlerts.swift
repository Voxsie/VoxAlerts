import UIKit

public struct VoxAlert {
    
    static var shared = VoxAlert()
    
    public private(set) var options: VoxOptions = VoxOptions(type: .success, hapticFeedbak: .success, position: .bottom)
    
    public init(options: VoxOptions) {
        self.options = options
    }
    
    public init() {
    }
    
    public static func show() {
        if let window = UIApplication.shared.windows.first {
            let alertView = VoxView(alertType: shared.options.type ?? .success, title: "2323", text: "23233")
            window.addSubview(alertView)
            alertView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                alertView.topAnchor.constraint(equalTo: window.topAnchor),
                alertView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                alertView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                alertView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
        }
    }
}
